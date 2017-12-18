require './models/user'
require './lib/message_sender'

class MessageResponder
  attr_reader :message
  attr_reader :bot
  attr_reader :user

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @user = User.find_or_create_by(uid: message.from.id)
  end

  def respond
    on /^\/start/ do
      answer_with_greeting_message
    end

    on /^\/stop/ do
      answer_with_farewell_message
    end

    on /^\Кошелек / do
      wallet
    end

    on /^\Депозиты/ do
      deposit 
    end

    on /^\Партнеры/ do
      #partners
    end

    on /^\О сервисе/ do
      #about
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

  def wallet
    text = "Ваш баланс: 0 BTC  ------------------------------" 
    
    kb = [
          [Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Пополнить', callback_data: 'touch'),
	    Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Вывести', callback_data: 'touch'),
	  ],[Telegram::Bot::Types::InlineKeyboardButton.new(text: 'История транзакций', callback_data: 'touch')]]
    
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb, resize_keyboard: true)
    
    bot.api.send_message(chat_id: message.chat.id, text: text, reply_markup: markup)
  end

end








