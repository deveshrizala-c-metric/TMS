class CreateIssueSummaries < ActiveRecord::Migration
  def change
    create_table :issue_summaries do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
