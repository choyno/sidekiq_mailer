class Notify < ActiveRecord::Base
  attr_accessible :email, :message, :name, :active

  def self.active
    self.where(active: true)
  end

end
