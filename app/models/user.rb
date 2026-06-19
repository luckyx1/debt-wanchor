# frozen_string_literal: true

# Represents a user in the system.
class User < ActiveRecord::Base
  validates :name, presence: true

  scope :debt_ranked, -> { order(debt: :desc) }
end
