class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses, force: true do |t|
       t.references :user, foreign_key: true
       t.string  :val
       t.boolean :is_check, default: true
    end
  end
end
