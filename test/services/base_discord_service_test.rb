# frozen_string_literal: true

require 'test_helper'

class BaseDiscordServiceTest < ActiveSupport::TestCase
  FakeResponse = Struct.new(:status)

  class FakeConnection
    attr_reader :headers, :body

    def initialize(status:)
      @status = status
    end

    def post
      request = Struct.new(:headers, :body).new({}, nil)
      yield request
      @headers = request.headers
      @body = request.body
      FakeResponse.new(@status)
    end
  end

  test 'post_to_discord sends a JSON content payload' do
    fake_connection = FakeConnection.new(status: 204)

    capture_io do
      Faraday.stub(:new, fake_connection) do
        BaseDiscordService.new(webhook_url: 'https://discord.test/webhook').post_to_discord(msg: 'hello discord')
      end
    end

    assert_equal 'application/json', fake_connection.headers['Content-Type']
    assert_equal({ 'content' => 'hello discord' }, JSON.parse(fake_connection.body))
  end

  test 'post_to_discord reports success for Discord no-content response' do
    fake_connection = FakeConnection.new(status: 204)

    output = capture_io do
      Faraday.stub(:new, fake_connection) do
        BaseDiscordService.new(webhook_url: 'https://discord.test/webhook').post_to_discord(msg: 'hello discord')
      end
    end.first

    assert_includes output, 'MSG sent to discord!'
  end

  test 'post_to_discord reports failure for non-Discord-success response' do
    fake_connection = FakeConnection.new(status: 500)

    output = capture_io do
      Faraday.stub(:new, fake_connection) do
        BaseDiscordService.new(webhook_url: 'https://discord.test/webhook').post_to_discord(msg: 'hello discord')
      end
    end.first

    assert_includes output, 'MSG FAILED to send to discord'
  end

  test 'initialization fails without a configured webhook URL' do
    error = assert_raises(RuntimeError) do
      BaseDiscordService.new(webhook_url: nil)
    end

    assert_equal 'Please set WANIKANI_DISCORD_WEBHOOK_URL', error.message
  end
end
