class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :comment, presence: true
  #投稿と通知モデルの紐付け
  has_many :notifications, dependent: :destroy
end
