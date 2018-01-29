
require 'http'
require 'json'

class  GenerateDash 
def generate
response = HTTP.post("https://spectrocoin.com/api/r/oauth2/auth", :json =>  
{
  "client_id": "wallet_fe17081746ee5ffb768493c541f7132f",
  "client_secret": "secretsecret",
  "version": "1.0",
  "scope": "user_account send_currency currency_exchange"
}
)
obj = JSON.parse(response)
token = obj['access_token']

generate = HTTP.auth("Bearer #{token}").get("https://spectrocoin.com/api/r/wallet/deposit/dash/fresh").body.readpartial
obj2 = JSON.parse(generate)
address = obj2['cryptoAddress']
p address
end
end

p GenerateDash.new.generate



