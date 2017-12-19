class CreateWallets < ActiveRecord::Migration[5.1]
  def change
    create_table :wallets, force: true do |t|
       t.references :user, foreign_key: true
       t.decimal :coins
    end
  end
end
