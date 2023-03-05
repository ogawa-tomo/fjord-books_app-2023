class AddIndexToReportMentionRelationships < ActiveRecord::Migration[7.0]
  def change
    add_index :report_mention_relationships, [:mentioned_report_id, :mentioning_report_id], unique: true, name: 'report_mention_relationship_index'
  end
end
