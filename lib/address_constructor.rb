require 'coinbase/wallet'

class AddressConstructor
   
  attr_reader :client

  def initialize
    @client = Coinbase::Wallet::Client.new(api_key: "9cIzFKBuopI7SOo7", api_secret: "k0FRfiXKV6DjFt7ZboReQVZYo4x9ZvM9")
    @ltc_wallet = client.account('bc3b88f1-3480-583e-af15-73bfbb119548')
    @eth_wallet = client.account('6c7ed5c0-5db0-5b87-aa6d-2cbf9634f83d')
    @bch_wallet = client.account('27402c2e-9278-5ec0-8be4-e37b64464358')
    @btc_wallet = client.account('d88b1c58-b048-5924-b226-cb1aef4b6df3')
  end

  def generate_btc
    p @btc_wallet.create_address.address
  end
  
  def generate_ltc
    p @ltc_wallet.create_address.address
  end
 
  def generate_eth
    p @eth_wallet.create_address.address
  end 

  def generate_bch
    p @bch_wallet.create_address.address
  end 

  def generate_dash
    "Делаю"
  end
  

end


# puts "%s" % Exmo::API.api_query('deposit_address').inspect

# btc ltc etc bcc