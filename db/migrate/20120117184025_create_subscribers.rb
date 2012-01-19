class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :name
      t.string :email
      t.boolean :doesnt_need_bin
      t.integer :plan_id
      t.string :stripe_customer_token
      t.boolean :cash

      t.timestamps
    end
  end
end
