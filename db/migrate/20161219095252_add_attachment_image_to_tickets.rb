class AddAttachmentImageToTickets < ActiveRecord::Migration
  def self.up
    change_table :tickets do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :tickets, :image
  end
end
