# frozen_string_literal: true

require_relative 'game'

class ReadGamesLogs
  attr_accessor :games

  def initialize(log_path)
    @file_lines = File.open(log_path).readlines
    @games = []
  end

  def self.perform(log_path)
    new(log_path).mount_games_log
  end

  def mount_games_log
    file_lines.each do |line|
      create_game(line)
      add_players(line)
      get_kills(line)
    end
    games.map(&:to_h)
  end

  private

  attr_accessor :file_lines

  def create_game(line)
    return unless line[/InitGame:/]

    game_id = "game_#{games.size}"
    game = Game.new(game_id)
    games.push(game)
  end

  def add_players(line)
    return unless line[/ClientUserinfoChanged:/]

    game = games.last
    player_name = line.match(/n\\(?<player_name>.*?)\\t/)[:player_name]
    game.add_player(player_name)
  end

  def get_kills(line)
    return unless line[/Kill:/]

    game = games.last
    kill_info = line.match(/Kill:(\s\d{1,4}){1,3}:\s(?<killer>.*?)\skilled\s(?<killed>.*?)\sby\s(?<mean>.*?)$/)
    killer = kill_info[:killer]
    killed = kill_info[:killed]
    mean = kill_info[:mean]

    game.add_kill(killer, killed, mean)
  end
end
