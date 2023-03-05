# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  has_many :mentioned_from, class_name: 'ReportMentionRelationship', foreign_key: :mentioned_report_id, dependent: :destroy, inverse_of: 'mentioned_report'
  has_many :mentioned_reports, through: :mentioned_from, source: :mentioning_report

  has_many :mentioning_to, class_name: 'ReportMentionRelationship', foreign_key: :mentioning_report_id, dependent: :destroy, inverse_of: 'mentioning_report'
  has_many :mentioning_reports, through: :mentioning_to, source: :mentioned_report

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end
end
