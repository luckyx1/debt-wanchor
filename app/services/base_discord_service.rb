# frozen_string_literal: true

# Represents generic logic to extract data from Wanikani
class BaseDiscordService
  def initialize(webhook_url: default_webhook_url)
    raise 'Please set WANIKANI_DISCORD_WEBHOOK_URL' if webhook_url.blank?

    @webhook_url = webhook_url
  end

  def post_to_discord(msg:)
    con = ::Faraday.new(url: @webhook_url)
    response = con.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = { content: msg }.to_json
    end
    if response.status == 204
      puts 'MSG sent to discord!'
    else
      puts 'MSG FAILED to send to discord'
    end
  end

  private

  def default_webhook_url
    ENV['WANIKANI_DISCORD_WEBHOOK_URL'] ||
      Rails.application.credentials[:wanikani_discord_webhook_url]
  end
end
