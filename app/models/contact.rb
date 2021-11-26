class Contact < ApplicationRecord
  enum subject: [:service,:violation,:other_question]
  #validates :message, presence: true
  validates :message, {presence: true, length: {maximum: 1000}}
end
