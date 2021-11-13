class Contact < ApplicationRecord
  enum subject: [:service,:violation,:other_question]
end
