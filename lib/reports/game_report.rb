# frozen_string_literal: true

require_relative 'base_report'

# Setting the content and name of Game report
class GameReport < BaseReport
  def self.report_content(game)
    game_id, report = game.first
    Hash[game_id, report.reject { |k| k == :kills_by_means }]
  end

  private

  def report_name
    'game_report'
  end
end
