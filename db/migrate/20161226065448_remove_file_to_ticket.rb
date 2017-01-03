class RemoveFileToTicket < ActiveRecord::Migration
  def change
    remove_column :tickets, :File, :string
  end
end
