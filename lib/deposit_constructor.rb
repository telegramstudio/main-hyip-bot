
class DepositConstructor
  attr_reader :coins
  

  def initialize(options)
    @coins = options[:coins]
  end

  def calculate
    if coins <= 0.011
     3
    elsif coins <= 0.028
     4
    else
     5
    end 
  end 

 
end


DepositConstructor.new(coins: 0.029).calculate




