class NotifiesController < ApplicationController

  before_filter :find_by_id , :only => [:edit, :edit, :update, :destroy, :notify]

  def index
    @notifies = Notify.active
  end

  def show
  end

  def new
    @notify = Notify.new
  end

  def create
    @notify = Notify.new(params[:notify])
    @notify.active = true
   if  @notify.save
     flash[:notice] = "Successfully save!"
     redirect_to notifies_path

    Notifications.delay.notify(@notify)
   else
     render :new
   end
  end

  def update
    if @notify.update_attributes(params[:notify])
     flash[:notice] = "Successfully update!"
     redirect_to notifies_path
    else
      render :edit
    end
  end

  def destroy
    if @notify.update_attributes({active: false})
     flash[:notice] = "Successfully Deleted"
     redirect_to notifies_path
    else
      render :index
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
