require './models/user'
require './models/wallet'
require './models/deposit'
require './lib/message_sender'
require './lib/keyboard'
require './lib/text'
require './lib/deposit_constructor'
require './lib/address_constructor'


class MessageResponder
  attr_reader :message
  attr_reader :bot
  attr_reader :user
  attr_reader :wallet
  attr_reader :deposit

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @user = User.find_or_create_by(uid: message.from.id)
    @wallet = Wallet.find_or_create_by(user_id: @user.id)
  end

  def callback
    # Пополнить  ########################################################################################
    
    if message.data == 'add_money_call'
      kb = KeyBrd.new.add_money_keyboard
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb, resize_keyboard: true)
      bot.api.send_message(chat_id: message.from.id, text: "Выберите свою валюту:", reply_markup: markup)
    
    # Внести депозит ####################################################################################
    
    elsif message.data == 'add_deposit_call'
      kb = KeyBrd.new.add_deposit_keyboard
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb, resize_keyboard: true)
      bot.api.send_message(chat_id: message.from.id, text: "Выберите валюту депозита:", reply_markup: markup)
    
    elsif message.data == 'depo_btc'
        bot.api.send_message(chat_id: message.from.id, text: "Укажите сумму депозита. Сумма спишется с вашего кошелька.")  
    
    elsif message.data == 'add_btc'
      bot.api.send_message(chat_id: message.from.id, text: "#{AddressConstructor.new.generate_btc}")
      bot.api.send_message(chat_id: message.from.id, text: "Отправьте средства на указаный адрес и проверьте баланс")
    elsif message.data == 'add_bch'
      bot.api.send_message(chat_id: message.from.id, text: "#{AddressConstructor.new.generate_bch}")
      bot.api.send_message(chat_id: message.from.id, text: "Отправьте средства на указаный адрес и проверьте баланс")
    elsif message.data == 'add_ltc'
      bot.api.send_message(chat_id: message.from.id, text: "#{AddressConstructor.new.generate_ltc}")
      bot.api.send_message(chat_id: message.from.id, text: "Отправьте средства на указаный адрес и проверьте баланс")
    elsif message.data == 'add_dash'
      bot.api.send_message(chat_id: message.from.id, text: "#{AddressConstructor.new.generate_dash}")
      bot.api.send_message(chat_id: message.from.id, text: "Отправьте средства на указаный адрес и проверьте баланс")
    elsif message.data == 'add_eth'
      bot.api.send_message(chat_id: message.from.id, text: "#{AddressConstructor.new.generate_eth}")
      bot.api.send_message(chat_id: message.from.id, text: "Отправьте средства на указаный адрес и проверьте баланс")


    elsif message.data == 'draw_money_call'
      bot.api.send_message(chat_id: message.from.id, text: "Вывод средств")
    elsif message.data == 'history_money'
      bot.api.send_message(chat_id: message.from.id, text: "История транзакций")
    elsif message.data == 'help'
      text = TextFormatter.new.help_text

      kb = KeyBrd.new.help_keyboard

      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb, resize_keyboard: true)

      bot.api.send_message(chat_id: message.from.id, text: text, reply_markup: markup)

    end
  end

  def respond
    
    on /^\/btc (.+)/ do |arg|
      if @user.wallet.coins.to_f < arg.to_f
         bot.api.send_message(chat_id: message.from.id, text: "Недостаточно средств на кошельке.")
      else
        @sum = @wallet.coins.to_f - arg.to_f
        @wallet.update(coins: @sum)
        @percent = DepositConstructor.new(coins: arg.to_f).calculate
        @d = Deposit.create(user_id: @user.id, coin: 'btc', coins: arg.to_f, percent: @percent)
        bot.api.send_message(chat_id: message.chat.id, text: "Открыт депозит на сумму #{arg.to_f} под #{@percent}%") 
      end
    end
    
    on /^\/start (.+)/ do |arg|
      @user.update(ref: arg)
      answer_with_greeting_message
    end

    on /^\/start/ do
      answer_with_greeting_message
    end

    on /^\/stop/ do
      answer_with_farewell_message
    end

    on /^\Кошелек (.+)/ do
      answer_wallet
    end

    on /^\Депозиты/ do
      answer_deposit
    end

    on /^\Партнеры/ do
      answer_partners
    end

    on /^\О сервисе/ do
      answer_about
    end

    on /^\/d_wallet/ do
      Wallet.destroy_all
    end

    on /^\/d_deposit/ do
      Deposit.destroy_all
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
        answers = ["Кошелек \xF0\x9F\x92\xB0", "Депозиты \xF0\x9F\x92\xBC", "Партнеры \xF0\x9F\x91\xA5", "О сервисе \xF0\x9F\x91\xA5"]
        #answers = ["Кошелек", "Депозиты", "Партнеры", "О сервисе"]

    MessageSender.new(bot: bot, chat: message.chat, text: text, answers: answers).send
  end

  def answer_wallet
    coins = @user.wallet.coins
    if coins == 0
      text = "Ваш баланс:  0.00000000 BTC"
    else
      rub  = coins.to_f * 982561.01
      dol  = coins.to_f * 3539
      text = "
Ваш баланс: 
#{coins.to_f} BTC = $#{dol} = #{rub} руб.
#{coins.to_f} BCH = $#{dol} = #{rub} руб.
#{coins.to_f} LTC = $#{dol} = #{rub} руб.
#{coins.to_f} ETH = $#{dol} = #{rub} руб.
#{coins.to_f} DASH = $#{dol} = #{rub} руб.
      "
    end
      
    kb = KeyBrd.new.wallet_keyboard 
  
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb, resize_keyboard: true)
    
    bot.api.send_message(chat_id: message.chat.id, text: text, reply_markup: markup)
  end

  def answer_deposit
    if @user.deposits.count < 0
      text = "Ваши депозиты: 0.00000000 BTC"
    else
      out = ""
        @user.deposits.each do |deposit|
          out += "*#{deposit.coins.to_f} BTC"
        end
    end
     p out 
     text = "Ваши депозиты: 
     #{out}
     "
      
    kb = KeyBrd.new.deposit_keyboard
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb, resize_keyboard: true) 
    bot.api.send_message(chat_id: message.chat.id, text: text, reply_markup: markup)
  end

  def answer_about
    text = TextFormatter.new.text
   
    
    kb = KeyBrd.new.about_keyboard

    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb, resize_keyboard: true)

    bot.api.send_message(chat_id: message.chat.id, text: text, reply_markup: markup)

  end

  def answer_partners
    text = TextFormatter.new.partners_text("#{@user.uid}", "#{@user.ref}")
    bot.api.send_message(chat_id: message.chat.id, text: text)
  end
 
   

end







