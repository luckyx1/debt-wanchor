# frozen_string_literal: true

# Represents generic logic to extract data from Wanikani
class BaseDiscordService
  # move these to config
  DEBT_WANI = 'https://discord.com/api/webhooks/1146632196459864114/7jm9OTdacceEr_lmXNzpakMSxK24tCPaEoxfmrfQ-bUCSDjQa8iVPgvCm3p_NG6C1TBm'
  WANIKANI_URL = 'https://discord.com/api/webhooks/1146637394372739194/Hm6yk-ouh9QsFCi7asJgLNb5IhhnZboDWUJM2X_UCd4xEIAjUCWw856MpGvvwwQD662g'

  def post_to_discord(msg:)
    con = ::Faraday.new(url: WANIKANI_URL)
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
end
