# frozen_string_literal: true

# Represents generic logic to evaluate for the App
class Home < ActiveRecord::Base
  # Returns String representation of wanikani data lesson and reviews
  def self.evaluate_wani
    result = []
    User.all.each do |user|
      summary_data = SummaryWanikaniService.new(username: user.name).fetch_summary_data
      lessons = get_lesson(summary_data)
      reviews = get_review(summary_data)
      result << "#{user.name} has #{lessons} lessons to do and #{reviews} review to do"
    end
    result.join(' , ')
  end

  # Returns count of lessons from wanikani data
  def self.get_lesson(data_from_wanikani)
    lesson_to_do = data_from_wanikani.fetch('lessons')[0].fetch('subject_ids')
    lesson_to_do.count
  end

  # Return count of reviews from wanikani data
  def self.get_review(data_from_wanikani)
    reviews_to_do = data_from_wanikani.fetch('reviews')[0].fetch('subject_ids')
    reviews_to_do.count
  end
end
