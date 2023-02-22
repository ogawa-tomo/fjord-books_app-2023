# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :picture
  validate :validate_picture

  private

  def validate_picture
    if %w[image/jpg image/jpeg image/png image/gif].exclude?(picture.blob.content_type)
      picture.purge
      errors.add(:base, I18n.t('activerecord.errors.user.picture.invalid_extension'))
    end
  end
end
