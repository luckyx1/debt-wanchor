# frozen_string_literal: true

# HomeController hanldes showing debt ranked by who has the most and entering new entry
class HomeController < ApplicationController
  def index
    @users = User.debt_ranked
  end

  def evaluate_wanikani
    puts Home.evaluate_wani
    puts "hello world"
    redirect_to home_index_path
  end
end
