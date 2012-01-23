class Subscriber < ActiveRecord::Base
  belongs_to :plan
  belongs_to :building
  validates_presence_of :plan_id
  validates_presence_of :email
  attr_accessor :stripe_card_token
  

  
  def save_with_payment
    if valid?
      customer = Stripe::Customer.create( :description => email, :card => stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
  
  def payment(plan_id, weeks)
    if valid?
      customer = Stripe::Customer.retrieve(self.stripe_customer_token)     
      if plan_id == 1
        amount = weeks*500+2800
      elsif plan_id == 2
        amount = weeks*800+2800
      elsif plan_id == 3
        amount = weeks*800
      elsif plan_id == 4
        amount = weeks*1100
      end
      Stripe::Charge.create(:amount => amount, :currency => "usd", :customer => customer.id)
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
