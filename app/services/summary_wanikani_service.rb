# frozen_string_literal: true

# Represents generic logic to extract data from Wanikani
class SummaryWanikaniService < BaseWanikaniService
  def fetch_summary_data
    fetch_data(summary_url)
  end

  private

  def summary_url
    'summary'
  end
end
