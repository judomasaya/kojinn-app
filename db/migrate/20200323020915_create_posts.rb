class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :name
      t.text :age
      t.text :title
      t.text :content
      t.text :allergy
      t.text :kusuri
      t.text :image
      t.timestamps
    end
  end
end

# text型のcontent name title ageカラムを追加