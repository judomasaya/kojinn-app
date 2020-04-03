class Post < ApplicationRecord

  belongs_to :user
  has_many :comments

#   def self.search(search)
#     return Post.all unless search
#     Post.where('text LIKE(?)', "%#{search}%")
#   end
# end
def self.search(search)
  if search
    Post.where('text LIKE(?)', "%#{search}%")
  else
    Postt.all
  end
end
end
