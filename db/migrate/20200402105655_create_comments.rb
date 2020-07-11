class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id #コメントを投稿したユーザーのidを保存するカラムがuser_idとなります。
      t.integer :post_id #コメントはどのツイートに対してのコメントなのか明示する必要があります。結びつくツイートのidを保存するカラムがpost_idとなります。
      t.text :text
      t.timestamps
    end
  end
end
