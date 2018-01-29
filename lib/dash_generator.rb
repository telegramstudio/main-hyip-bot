
require 'http'
require 'json'

class  DashGenerator 
def generate
response = HTTP.post("https://spectrocoin.com/api/r/oauth2/auth", :json =>  
{
  "client_id": "wallet_3141887bfe4c12536b40b137b8925b48",
  "client_secret": "Jailbreakme19",
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





