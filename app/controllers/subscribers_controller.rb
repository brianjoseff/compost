class SubscribersController < ApplicationController
  before_filter :admin_user, :except => [:new, :create, :show]

  def index
    @subscribers = Subscriber.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @subscribers }
    end
  end

  # GET /subscribers/1
  # GET /subscribers/1.json
  def show
    @subscriber = Subscriber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @subscriber }
    end
  end

  # GET /subscribers/new
  # GET /subscribers/new.json
  def new
    @weeks = weeks_to_charge_for
    @plan = Plan.find(params[:plan_id])
    @subscriber = @plan.subscribers.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @subscriber }
    end
  end

  # GET /subscribers/1/edit
  def edit
    @subscriber = Subscriber.find(params[:id])
  end

  # POST /subscribers
  # POST /subscribers.json
  def create
    @weeks = weeks_to_charge_for
    @subscriber = Subscriber.new(params[:subscriber])
    if @subscriber.save_with_payment
      if @subscriber.doesnt_need_bin == false
        @subscriber.payment(@subscriber.plan_id, @weeks)
        SignupMailer.new_subscriber(@subscriber).deliver
      end
      redirect_to @subscriber, :notice => "Thank you for subscribing!"
      
    else
      render :new
    end

  end

  # PUT /subscribers/1
  # PUT /subscribers/1.json
  def update
    @subscriber = Subscriber.find(params[:id])
    @weeks = weeks_to_charge_for
    respond_to do |format|
      if @subscriber.update_attributes(params[:subscriber])
        format.html { redirect_to @subscriber, :notice => 'Subscriber was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @subscriber.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subscribers/1
  # DELETE /subscribers/1.json
  def destroy
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy

    respond_to do |format|
      format.html { redirect_to subscribers_url }
      format.json { head :ok }
    end
  end
  
  private
  
    def weeks_to_charge_for
      winterservicestart = 1328184000
      now = Time.now.to_i
      elapsed = winterservicestart - now
      weeks = elapsed/604800
      case weeks
        when -1..1 then return 6
        when 1..2 then return 5
        when 2..3 then return 4
        when 3..4 then return 3
        when 4..5 then return 2
        when 5..6 then return 1
        when 6..10 then return 0
      end    
    end  
end
