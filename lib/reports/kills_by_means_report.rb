# frozen_string_literal: true

require_relative 'base_report'

# Setting the content and name of Kill by Means Report
class KillsByMeansReport < BaseReport
  def self.report_content(game)
    game_id, report = game.first

    { game_id => report.select { |k| k == :kills_by_means } }
  end

  private

  def report_name
    'kills_by_means_report'
  end
end
