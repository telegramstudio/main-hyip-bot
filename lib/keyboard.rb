class KeyBrd


     def help_keyboard
         [
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bitcoin [BTC]',  url: 'https://bitcoin.org/ru/'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bitcoin Cash [BCH]',  url: 'https://www.bitcoincash.org/')
          ],
          [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Litecoin [LTC]',  url: 'https://litecoin.org/'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Dash [DASH]',  url: 'https://www.dash.org/')
          ],
          [Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Ethereum [ETH]',  url: 'https://www.ethereum.org/')]
         ]
      end


     def about_keyboard
         [
          [Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Конвертер',  url: 'http://ru.investing.com/currencies/ltc-rub-converter')],
          [Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Помощь', callback_data: 'help')]
         ]
      end
 
      def deposit_keyboard
         [[
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Открыть депозит',  callback_data: 'add_deposit_call')
         ],
         [
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'История депозитов', callback_data: 'history_deposits')
         ]]
      end

      def add_money_keyboard  
          [
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bitcoin [BTC]', callback_data: 'add_btc'),
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bitcoin Cash [BCH]', callback_data: 'add_bch')
             ],
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Litecoin [LTC]', callback_data: 'add_ltc'),
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Ethereums [ETH]', callback_data: 'add_eth')
             ],
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Dash [DASH]', callback_data: 'add_dash')
             ]
           ]
      end

      def about_depo_keyboard  
          [
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bitcoin [BTC]', callback_data: 'about_btc'),
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bitcoin Cash [BCH]', callback_data: 'about_bch')
             ],
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Litecoin [LTC]', callback_data: 'about_ltc'),
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Ethereums [ETH]', callback_data: 'about_eth')
             ],
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Dash [DASH]', callback_data: 'about_dash')
             ]
           ]
      end


      def add_deposit_keyboard
           [
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bitcoin [BTC]', callback_data: 'depo_btc'),
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bitcoin Cash [BCH]', callback_data: 'depo_bch')
             ],

             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Litecoin [LTC]', callback_data: 'depo_ltc'),
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Dash [DASH]', callback_data: 'depo_dash')
             ],
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Ethereums [ETH]', callback_data: 'depo_eth')
             ]
           ]
       end

       def wallet_keyboard
        [
          [ Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Пополнить', callback_data: 'add_money_call'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Вывести', callback_data: 'draw_money_call'),
          ],
          [
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'История транзакций', callback_data: 'history_money')]]
        end
  
end
