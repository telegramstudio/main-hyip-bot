require 'active_record'

class Deposit < ActiveRecord::Base
  belongs_to :user
end
