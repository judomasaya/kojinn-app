class Post < ApplicationRecord
  validates :name, :age, :title, :allergy, :kusuri, presence: true

  belongs_to :user
  has_many :comments

#   def self.search(search)
#     return Post.all unless search
#     Post.where('text LIKE(?)', "%#{search}%")
#   end
# end
  def self.search(search)
    if search
      Post.where('name LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end
end
