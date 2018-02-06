class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses, force: true do |t|
       t.references :user, foreign_key: true
       t.string  :val
       t.boolean :is_check, default: false
                      
       t.boolean :is_btc,  default: false
       t.boolean :is_bch,  default: false
       t.boolean :is_ltc,  default: false
       t.boolean :is_eth,  default: false
       t.boolean :is_dash, default: false
    end
  end
end
