class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      # 「実際にpostsテーブルを作成する」という仕様が
      # マイグレーションファイルに記載されています。
      t.text :nickname
      t.text :name
      t.text :age
      t.text :title
      t.text :content
      t.text :allergy
      t.text :kusuri
      t.text :image
      t.text :sex
      t.text :onset
      t.text :asthma
      t.timestamps
    end
  end
end

# text型のcontent name title ageカラムを追加