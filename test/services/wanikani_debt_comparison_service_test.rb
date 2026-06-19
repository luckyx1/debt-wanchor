# frozen_string_literal: true

require 'test_helper'

class WanikaniDebtComparisonServiceTest < ActiveSupport::TestCase
  test 'compares user debt to peer debt' do
    user = { name: 'robert', lessons: 3, reviews: 2, debt: 5 }
    peer = { name: 'peer', lessons: 4, reviews: 6, debt: 10 }

    comparison = WanikaniDebtComparisonService.new(user:, peer:).call

    assert_equal user, comparison[:user]
    assert_equal peer, comparison[:peer]
    assert_equal(-5, comparison[:difference])
    assert_equal 0.5, comparison[:ratio]
  end

  test 'reports equal debt with a one-to-one ratio' do
    user = { name: 'robert', lessons: 2, reviews: 3, debt: 5 }
    peer = { name: 'peer', lessons: 1, reviews: 4, debt: 5 }

    comparison = WanikaniDebtComparisonService.new(user:, peer:).call

    assert_equal 0, comparison[:difference]
    assert_equal 1.0, comparison[:ratio]
  end

  test 'reports equal debt when both users have no debt' do
    user = { name: 'robert', lessons: 0, reviews: 0, debt: 0 }
    peer = { name: 'peer', lessons: 0, reviews: 0, debt: 0 }

    comparison = WanikaniDebtComparisonService.new(user:, peer:).call

    assert_equal 0, comparison[:difference]
    assert_equal 1.0, comparison[:ratio]
  end

  test 'returns no ratio when peer debt is zero and user debt is not' do
    user = { name: 'robert', lessons: 2, reviews: 3, debt: 5 }
    peer = { name: 'peer', lessons: 0, reviews: 0, debt: 0 }

    comparison = WanikaniDebtComparisonService.new(user:, peer:).call

    assert_equal 5, comparison[:difference]
    assert_nil comparison[:ratio]
  end
end
