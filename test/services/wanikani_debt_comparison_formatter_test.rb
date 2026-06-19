# frozen_string_literal: true

require 'test_helper'

class WanikaniDebtComparisonFormatterTest < ActiveSupport::TestCase
  test 'formats a Discord comparison message' do
    comparison = {
      user: { name: 'robert', lessons: 3, reviews: 2, debt: 5 },
      peer: { name: 'peer', lessons: 4, reviews: 6, debt: 10 },
      difference: -5,
      ratio: 0.5
    }

    message = WanikaniDebtComparisonFormatter.new(comparison:).call

    assert_equal <<~MESSAGE.chomp, message
      **WaniKani debt comparison**
      **robert:** 5 total (3 lessons, 2 reviews)
      **peer:** 10 total (4 lessons, 6 reviews)
      robert has 5 fewer items than peer. Ratio: 0.5x.
    MESSAGE
  end

  test 'formats an equal comparison' do
    comparison = {
      user: { name: 'robert', lessons: 2, reviews: 3, debt: 5 },
      peer: { name: 'peer', lessons: 1, reviews: 4, debt: 5 },
      difference: 0,
      ratio: 1.0
    }

    message = WanikaniDebtComparisonFormatter.new(comparison:).call

    assert_includes message, 'robert and peer are even. Ratio: 1.0x.'
  end

  test 'formats a comparison without a finite ratio' do
    comparison = {
      user: { name: 'robert', lessons: 2, reviews: 3, debt: 5 },
      peer: { name: 'peer', lessons: 0, reviews: 0, debt: 0 },
      difference: 5,
      ratio: nil
    }

    message = WanikaniDebtComparisonFormatter.new(comparison:).call

    assert_includes message, 'robert has 5 more items than peer.'
    assert_includes message, 'Ratio unavailable because peer has no debt.'
  end
end
