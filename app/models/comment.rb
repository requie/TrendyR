class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment

  validates :author_id, :text, presence: true

  belongs_to :commentable, :polymorphic => true
  belongs_to :user, foreign_key: "author_id"

  default_scope -> { order('created_at ASC') }

  def self.find_commentable(commentable_type, commentable_id)
    commentable_type.constantize.find(commentable_id)
  end
end