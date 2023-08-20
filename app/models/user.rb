# frozen_string_literal: true

# Represents a user in the system.
class User < ActiveRecord::Base
  validates :name, presence: true
end
