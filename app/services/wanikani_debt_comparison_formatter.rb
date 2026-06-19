# frozen_string_literal: true

# Formats a WaniKani debt comparison for a Discord webhook message.
class WanikaniDebtComparisonFormatter
  def initialize(comparison:)
    @comparison = comparison
  end

  def call
    [
      '**WaniKani debt comparison**',
      summary_line(user),
      summary_line(peer),
      result_line
    ].join("\n")
  end

  private

  attr_reader :comparison

  def user
    comparison.fetch(:user)
  end

  def peer
    comparison.fetch(:peer)
  end

  def difference
    comparison.fetch(:difference)
  end

  def ratio
    comparison.fetch(:ratio)
  end

  def summary_line(summary)
    "**#{summary.fetch(:name)}:** #{summary.fetch(:debt)} total " \
      "(#{summary.fetch(:lessons)} lessons, #{summary.fetch(:reviews)} reviews)"
  end

  def result_line
    "#{difference_text} #{ratio_text}"
  end

  def difference_text
    return fewer_items_text if difference.negative?
    return more_items_text if difference.positive?

    even_text
  end

  def fewer_items_text
    "#{user[:name]} has #{difference.abs} fewer items than #{peer[:name]}."
  end

  def more_items_text
    "#{user[:name]} has #{difference} more items than #{peer[:name]}."
  end

  def even_text
    "#{user[:name]} and #{peer[:name]} are even."
  end

  def ratio_text
    return "Ratio unavailable because #{peer[:name]} has no debt." if ratio.nil?

    "Ratio: #{ratio}x."
  end
end
