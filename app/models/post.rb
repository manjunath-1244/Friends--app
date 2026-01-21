class Post < ApplicationRecord
  #associations
  belongs_to :user
  #association with comments
  has_many :comments, dependent: :destroy
  # validation
  validates :content, presence: true
 
  # Full-text search using pg_search for posts
  include PgSearch::Model

  pg_search_scope :search_by_content,
    against: :content,
    using: {
      tsearch: {
        prefix: true
      }
    }
end
