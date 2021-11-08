class Post < ApplicationRecord
  belongs_to :user
  attachment :cooking_image
end
