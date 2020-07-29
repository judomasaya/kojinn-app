class Post < ApplicationRecord
  validates :name, :age, :onset, :title, :allergy, presence: true

  belongs_to :user
  has_many :comments

#   def self.search(search)
#     return Post.all unless search
#     Post.where('text LIKE(?)', "%#{search}%")
#   end
# end
# どっちでも大丈夫
  def self.search(search)
    if search
      Post.where('name LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end
end

# モデルにテーブルから検索するためのメソッドsearchを定義していきます。
# MVCの観点で検索するなどのビジネスロジック（プログラムの処理の流れ）は、メソッドとしてモデルにまとめて定義するようにします。
# 理由は、そのメソッドを別の場所でも使うことができ、チーム開発などにおいても便利だからです。

# モデル.where(条件)のように引数部分に条件を指定することで、テーブル内の条件に一致したレコードのインスタンスを配列の形で取得できます。