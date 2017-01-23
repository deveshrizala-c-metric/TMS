class AddDeletedAtToIssueSummaries < ActiveRecord::Migration
  def change
    add_column :issue_summaries, :deleted_at, :datetime
    add_index :issue_summaries, :deleted_at
  end
end
