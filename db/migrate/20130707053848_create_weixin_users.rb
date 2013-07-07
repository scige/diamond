class CreateWeixinUsers < ActiveRecord::Migration
  def change
    create_table :weixin_users do |t|
      t.string   :open_id
      t.string   :fake_id
      t.string   :user_name
      t.string   :nick_name
      t.string   :remark_name

      t.string   :country
      t.string   :province
      t.string   :city
      t.integer  :sex
      t.integer  :group_id
      t.string   :signature

      t.string   :mobile
      t.string   :email
      t.integer  :birthyear
      t.string   :thumb

      t.timestamps
    end
  end
end
