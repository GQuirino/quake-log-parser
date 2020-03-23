require_relative 'lib/read_games_logs'
require_relative 'lib/reports/game_report'
require_relative 'lib/reports/kills_by_means_report'

task :parse_game_report do
  default_path = 'logs/game.log'
  puts "fillpath to game.log to parse (#{default_path}):"
  path = STDIN.gets.chomp
  path = path.empty? ? default_path : path

  games_logs_parsed = ReadGamesLogs.perform(path)

  puts GameReport.perform(games_logs_parsed)
  puts KillsByMeansReport.perform(games_logs_parsed)
end
