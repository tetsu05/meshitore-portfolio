class Contact < ApplicationRecord
  enum subject: [:service,:violation,:other_question]
  validates :name, presence: true
  validates :message, {presence: true, length: {maximum: 1000}}
  #メールアドレスのバリデーション
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  #電話番号のバリデーション
  validates :phone_number, presence: true, format: {with: /\A[0-9-]{,14}\z/}
end
