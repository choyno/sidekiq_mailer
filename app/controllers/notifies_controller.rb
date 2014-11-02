class NotifiesController < ApplicationController

  before_filter :find_by_id , :only => [:edit, :edit, :update, :destroy, :notify]

  def index
    @notifies = Notify.all
    @notify = Notify.new
    respond_to do |format|
      format.html
      format.json { render json: @notify }
    end
  end

  def show
  end

  def create
    @notify = Notify.new(params[:notify])
    @notify.active = true
    @notify.save
    #Notifications.delay.notify(@notify)
    respond_to do |format|
      format.json { render json: @notify }
    end
  end

  def update
    @notify.update_attributes(params[:notify])
     flash[:notice] = "Successfully update!"
     respond_to do |format|
       format.html { redirect_to notifies_path }
       format.json { render json: @notify }
     end
  end

  def destroy
    @notify.update_attributes({active: false})
    respond_to do |format|
      format.json { render json: @notify }
    end
  end

  def notify
    Notifications.delay.notify(@notify)

     flash[:notice] = "Successfully Notify"
     redirect_to notifies_path
  end

  private

  def find_by_id
    @notify =  Notify.find(params[:id])
  end

end
