# frozen_string_literal: true

class LinebotsController < ApplicationController
  # LINE APIを返すときはつける必要がある
  protect_from_forgery :except => [:create]
  before_action :validate_signature, only: [:create]

  def create
    client.parse_events_from(body).each do |event|
      client.reply_message(event['replyToken'], message(event))
    end
    head :ok
  end

  private

  def body
    @body ||= request.body.read
  end

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end
  end

  def validate_signature
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    head :bad_request unless client.validate_signature(body, signature)
  end

  def events
    @events ||= client.parse_events_from(body)
  end

  def message(event)
    # ここに書いていく
    p event
    @dresseds = Dressed.all
    case event
    when Line::Bot::Event::Postback
      LineBot::PostbackEvent.send(event['postback']['data'])
    when Line::Bot::Event::Message
      today = Date.today
      now = Time.current
      hour = now.hour
      day = now.day
      month = now.month

      case event['message']['type']
      when 'sticker' # スタンプイベントの時
        {
            "type": "text",
            "text": "毎日着替えて、最高の日々にしよう！！"
        }
      when 'text' # メッセージイベントの時
        if event['message']['text'] =~ /これまでの記録/
          @dresseds = Dressed.all
          len = @dresseds.length
          {
              "type": "text",
              "text": "これまでに" + len.to_s + "日着替えているね！"
          }
        elsif event['message']['text'] =~ /今月の記録/
          beginning_of_month = today.beginning_of_month
          @dresseds = Dressed.select('day').where('day >= ?', beginning_of_month)
          len = @dresseds.length
          percent = ((100 * len) / day)
          {
              "type": "text",
              "text": "今月の" + day.to_s + "日間で" + len.to_s + "日着替えているよ！" + percent.to_s + "%の達成率だね。"
          }

        elsif event['message']['text'] =~ /りょうた/
          {
              "type": "text",
              "text": "みっこ天才！"
          }
        elsif event['message']['text'] =~ /オキガエくん/
          {
              "type": "text",
              "text": "はい！オキガエくんだよ！朝、パジャマから着替えたら、パジャマをカゴに入れてね。"
          }
        # === ここに追加する ===
        # === ここに追加する ===
        else
          {
            "type": "text",
            "text": event['message']['text']
          }
        end
      end
    end
  end
end
