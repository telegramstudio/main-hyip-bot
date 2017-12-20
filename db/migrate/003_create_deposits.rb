class CreateDeposits < ActiveRecord::Migration[5.1]
  def change
    create_table :deposits, force: true do |t|
       t.references :user, foreign_key: true
       t.decimal  :coins
       t.string   :coin
       t.decimal  :percent
    end
  end
end
