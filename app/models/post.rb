class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :reactions
  has_many :users, through: :reactions

  def count_with_kind(arg)
    number = self.reactions.where(kind: arg).count
    return "#{arg} - #{number}" # rubocop:disable Style/RedundantReturn
  end

  def find_kind_user_relation(user)
    self.reactions.find_by(user_id: user.id).kind
  end
end
