require './models/user'
require './models/wallet'
require './lib/message_sender'

class MessageResponder
  attr_reader :message
  attr_reader :bot
  attr_reader :user
  attr_reader :wallet

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @user = User.find_or_create_by(uid: message.from.id)
    @wallet = Wallet.find_or_create_by(user_id: @user.id)
  end

  def callback
    if message.data == 'add_money_call'
      
      kb = [
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bitcoin [BTC]', callback_data: 'add_btc'),
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bitcoin Cash [BCH]', callback_data: 'add_bch')
             ],
          
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Litecoin [LTC]', callback_data: 'add_ltc'),
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bitcoin Gold [BTG]', callback_data: 'btg')
             ],
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Dash [DASH]', callback_data: 'add_dash'),
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Ethereums [ETH]', callback_data: 'add_eth')
             ],
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Monero [XMR]', callback_data: 'add_xmr'),
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Ripple [XRP]', callback_data: 'add_xrp')
             ],
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Ethereum classic [ETC]', callback_data: 'add_etc'),
             ]
           ]

    
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb, resize_keyboard: true)

    bot.api.send_message(chat_id: message.from.id, text: "Выберите свою валюту:", reply_markup: markup)
    
    elsif message.data == 'add_deposit_call'
            kb = [
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bitcoin [BTC]', callback_data: 'add_btc'),
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bitcoin Cash [BCH]', callback_data: 'add_bch')
             ],

             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Litecoin [LTC]', callback_data: 'add_ltc'),
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Bitcoin Gold [BTG]', callback_data: 'btg')
             ],
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Dash [DASH]', callback_data: 'add_dash'),
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Ethereums [ETH]', callback_data: 'add_eth')
             ],
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Monero [XMR]', callback_data: 'add_xmr'),
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Ripple [XRP]', callback_data: 'add_xrp')
             ],
             [
             Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Ethereum classic [ETC]', callback_data: 'add_etc'),
             ]
           ]

      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb, resize_keyboard: true)

      bot.api.send_message(chat_id: message.from.id, text: "Выберите валюту депозита:", reply_markup: markup)

    elsif message.data == 'add_btc'
      @sum == @user.wallet.coins.to_i + 0.5
      @user.wallet.update(coins: @sum)
      bot.api.send_message(chat_id: message.from.id, text: "Счет пополнен на 0.5 BTC")
    elsif message.data == 'draw_money_call'
      bot.api.send_message(chat_id: message.from.id, text: "Вывод средств")
    elsif message.data == 'history_money'
      bot.api.send_message(chat_id: message.from.id, text: "История транзакций")
    end
  end

  def respond
    on /^\/start/ do
      answer_with_greeting_message
    end

    on /^\/stop/ do
      answer_with_farewell_message
    end

    on /^\Кошелек/ do
      answer_wallet
    end

    on /^\Депозиты/ do
      answer_deposit
    end

    on /^\Партнеры/ do
      coming_soon
    end

    on /^\О сервисе/ do
      coming_soon
    end

    on /^\/clear/ do
      Wallet.destroy_all
    end

  end

  private

  def on regex, &block
    regex =~ message.text

    if $~
      case block.arity
      when 0
        yield
      when 1
        yield $1
      when 2
        yield $1, $2
      end
    end
  end

  def answer_with_greeting_message
    answer_with_message I18n.t('greeting_message')
 end

  def answer_with_farewell_message
    answer_with_message I18n.t('farewell_message')
  end

  def answer_with_message(text)
    answers = ["Кошелек", "Депозиты", "Партнеры", "О сервисе"]
    MessageSender.new(bot: bot, chat: message.chat, text: text, answers: answers).send
  end

  def answer_wallet
    coins = @user.wallet.coins
    text = "Ваш баланс: #{coins} BTC                       " 
    
    kb = [
          [ Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Пополнить', callback_data: 'add_money_call'),
	    Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Вывести', callback_data: 'draw_money_call'),
	  ],
          [
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'История транзакций', callback_data: 'history_money')]]
     
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb, resize_keyboard: true)
    
    bot.api.send_message(chat_id: message.chat.id, text: text, reply_markup: markup)
  end

  def answer_deposit
   text = "Ваши депозиты: 0 BTC                            "
   kb = [
         [Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Внести',  callback_data: 'add_deposit_call'),
          Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Текущие', callback_data: 'my_deposits_call')
         ],
         [Telegram::Bot::Types::InlineKeyboardButton.new(text: 'История депозитов', callback_data: 'history_deposits')]]

   markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb, resize_keyboard: true) 
   bot.api.send_message(chat_id: message.chat.id, text: text, reply_markup: markup)
  end

  def coming_soon
    bot.api.send_message(chat_id: message.chat.id, text: "Недоступно в демо режиме")
  end
  

end








