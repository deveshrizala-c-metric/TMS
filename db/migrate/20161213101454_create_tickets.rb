class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :issue_details
      t.string :file
      t.string :location
      t.string :status
      t.references :user, index: true, foreign_key: true
      t.references :department, index: true, foreign_key: true
      t.references :issue_summary, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
