class SignupMailer < ActionMailer::Base
  default :from => "brian.joseff@dartmouth.edu"
  
  def new_subscriber(subscriber)
    @subscriber = subscriber
    mail(:to => subscriber.email, :subject => "Dos Compost | new subscriber information")
  end
end
