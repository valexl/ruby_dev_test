class AddStatusToComment < ActiveRecord::Migration
  def change
    add_column :comments, :status, :string
  end
end
