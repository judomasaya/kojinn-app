class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id #誰が投稿したコメントなのか
      t.integer :post_id #どのツイートに対してのコメントなのかをカラムに追加
      t.timestamps
    end
  end
end
