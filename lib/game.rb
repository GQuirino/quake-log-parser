# frozen_string_literal: true

class Game
  attr_accessor :id, :players, :total_kills, :kills, :kills_by_means

  def initialize(id)
    @id = id
    @players = []
    @total_kills = 0
    @kills = Hash.new { |h, k| h[k] = 0 }
    @kills_by_means = Hash.new { |h, k| h[k] = 0 }
  end

  def add_player(player_name)
    players.push(player_name) unless players.include?(player_name)
  end

  def add_kill(killer, killed, mean)
    self.total_kills = increase_kill(self.total_kills)
    kills_by_means[mean] = increase_kill(kills_by_means[mean])

    if killer == '<world>'
      kills[killed] = decrease_kill(kills[killed])
    else
      kills[killer] = increase_kill(kills[killer])
    end
  end

  def to_h
    kills_sorted_desc = kills.sort_by { |k, v| v }.reverse.to_h

    Hash[id, {
      total_kills: total_kills,
      players: players,
      kills: kills_sorted_desc,
      kills_by_means: kills_by_means
    }]
  end

  private

  def increase_kill(kill)
    kill + 1
  end

  def decrease_kill(kill)
    kill - 1
  end
end
