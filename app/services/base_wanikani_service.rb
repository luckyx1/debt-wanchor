# frozen_string_literal: true

# Represents generic logic to extract data from Wanikani
class BaseWanikaniService
  BASE_URL = 'https://api.wanikani.com/v2/'

  def initialize(username:)
    key_name = "#{username}_wanikani_api_key".to_sym
    raise "Please set key in Rails credentials for #{key_name}" unless Rails.application.credentials.key?(key_name)

    @api_key = Rails.application.credentials.send(key_name)
  end

  def fetch_data(endpoint)
    conn = ::Faraday.new do |faraday|
      faraday.headers['Wanikani-Revision'] = '20170710'
      faraday.headers['Authorization'] = "Bearer #{@api_key}"
      faraday.adapter Faraday.default_adapter
    end
    response = conn.get(specific_url(endpoint))

    JSON.parse(response.body)['data']
  end

  private

  def specific_url(endpoint)
    BASE_URL + endpoint
  end
end
