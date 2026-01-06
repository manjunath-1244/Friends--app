class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :content, presence: true

  include PgSearch::Model

  pg_search_scope :search_by_content,
    against: :content,
    using: {
      tsearch: {
        prefix: true
      }
    }

    
end
