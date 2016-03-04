class AddStatusToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :status, :boolean
  end
end
