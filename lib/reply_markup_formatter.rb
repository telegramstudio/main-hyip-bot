class ReplyMarkupFormatter
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def get_markup
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: array.each_slice(2).to_a, one_time_keyboard: false, resize_keyboard: true)
  end
end
