require 'active_record'

class User < ActiveRecord::Base
  has_one :wallet
  has_many :deposits
end
