# frozen_string_literal: true

require 'test_helper'

class HomeTest < ActiveSupport::TestCase
  class FakeSummaryService
    SUMMARIES = {
      'robert' => {
        'lessons' => [{ 'subject_ids' => [1, 2, 3] }],
        'reviews' => [{ 'subject_ids' => [4, 5] }]
      },
      'peer' => {
        'lessons' => [{ 'subject_ids' => [6] }],
        'reviews' => [{ 'subject_ids' => [7, 8, 9, 10] }]
      }
    }.freeze

    def initialize(username:)
      @username = username
    end

    def fetch_summary_data
      SUMMARIES.fetch(@username)
    end
  end

  test 'get_lesson returns the number of lesson subject ids in summary data' do
    summary_data = {
      'lessons' => [{ 'subject_ids' => [1, 2, 3] }]
    }

    assert_equal 3, Home.get_lesson(summary_data)
  end

  test 'get_review returns the number of review subject ids in summary data' do
    summary_data = {
      'reviews' => [{ 'subject_ids' => [1, 2, 3, 4] }]
    }

    assert_equal 4, Home.get_review(summary_data)
  end

  test 'get_debt returns the combined lesson and review count' do
    summary_data = {
      'lessons' => [{ 'subject_ids' => [1, 2, 3] }],
      'reviews' => [{ 'subject_ids' => [4, 5] }]
    }

    assert_equal 5, Home.get_debt(summary_data)
  end

  test 'summary_for returns structured WaniKani counts for a user' do
    user = User.create!(name: 'robert', debt: 0)

    SummaryWanikaniService.stub(:new, ->(username:) { FakeSummaryService.new(username:) }) do
      assert_equal(
        { name: 'robert', lessons: 3, reviews: 2, debt: 5 },
        Home.summary_for(user)
      )
    end
  end

  test 'evaluate_wani returns a lesson and review summary for each user' do
    User.create!(name: 'robert', debt: 0)
    User.create!(name: 'peer', debt: 0)

    SummaryWanikaniService.stub(:new, ->(username:) { FakeSummaryService.new(username:) }) do
      assert_equal(
        'robert has 3 lessons to do and 2 review to do , peer has 1 lessons to do and 4 review to do',
        Home.evaluate_wani
      )
    end
  end
end
