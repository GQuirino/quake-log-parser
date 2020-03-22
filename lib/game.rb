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
    increase_kill(total_kills)
    kills_by_means[mean] = increase_kill(kills_by_means[mean])

    if killer == '<world>'
      kills[killed] = decrease_kill(kills[killed])
    else
      kills[killer] = increase_kill(kills[killer])
    end
  end

  private

  def increase_kill(kill)
    kill + 1
  end

  def decrease_kill(kill)
    kill - 1
  end
end
