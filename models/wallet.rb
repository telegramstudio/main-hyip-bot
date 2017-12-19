require 'active_record'

class Wallet < ActiveRecord::Base
  belongs_to :user
end
