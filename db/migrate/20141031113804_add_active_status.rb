class AddActiveStatus < ActiveRecord::Migration
  def up
    add_column :notifies, :active, :boolean, defaults: true
  end

end
