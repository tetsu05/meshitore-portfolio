class Contact < ApplicationRecord
  enum subject: [:service,:violation,:other_question]
  #validates :message, presence: true, lengh: {maximum: 140}
end
