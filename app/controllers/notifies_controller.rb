class NotifiesController < ApplicationController


  before_filter :find_by_id , :except => [:index]

  def index
    @notifies = Notify.active
    @notify = Notify.new

    respond_to  do |format|
      format.html
      format.js
    end
  end

  def show
    respond_to  do |format|
      format.html
      format.js
    end
  end

  def new
    @notify = Notify.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_by_id
    @notify =  Notify.find(params[:id])
  end

end
