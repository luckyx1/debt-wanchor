# frozen_string_literal: true

# Represents bg job running hourly to track wanikani debt
class UpdateDebtJob
  include Sidekiq::Job

  def perform(*args)
    # Do something
    puts 'starting job'
    # msg = [
    #   'I am a crime fighting digital bot',
    #   'I like to eat chips, ...computer chips',
    #   'I strive to execute to the best of my computative ability'
    # ].sample
    # BaseDiscordService.new.post_to_discord(msg: "posting every 5 min to test")
    # BaseDiscordService.new.post_to_discord(msg: Home.evaluate_wani)
    puts Home.evaluate_wani
    puts 'end job'
  end
end
