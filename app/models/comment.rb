class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true, dependent: :destroy
end
