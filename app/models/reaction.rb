class Reaction < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :kind, acceptance: {
    accept: %w[like neutral uninterested]
  }

  def self.kinds
    %w[like neutral uninterested]
  end
end
