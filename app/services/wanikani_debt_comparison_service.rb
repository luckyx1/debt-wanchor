# frozen_string_literal: true

# Compares the structured WaniKani debt summaries for a user and peer.
class WanikaniDebtComparisonService
  def initialize(user:, peer:)
    @user = user
    @peer = peer
  end

  def call
    {
      user:,
      peer:,
      difference: user_debt - peer_debt,
      ratio:
    }
  end

  private

  attr_reader :user, :peer

  def user_debt
    user.fetch(:debt)
  end

  def peer_debt
    peer.fetch(:debt)
  end

  def ratio
    return 1.0 if user_debt.zero? && peer_debt.zero?
    return if peer_debt.zero?

    user_debt.fdiv(peer_debt).round(2)
  end
end
