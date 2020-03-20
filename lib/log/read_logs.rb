class ReadLogs
  def initialize(log_path)
    @file = File.open(log_path)
    @file_lines = file.readlines
    @games_log = Hash.new { |hash, key| hash[key] = [] }
  end

  def self.perform(log_path)
    new(log_path).mount_games_log
  end

  def mount_games_log
    game_count = 0
    file_lines.each_with_index do |line, index|
      game_id = "game_#{game_count}"
      next_line = file_lines[index + 1]
      line = remove_time(line)

      games_log[game_id].push(line) if valid?(line)
      game_count += 1 if match_began?(next_line)
    end

    games_log
  end

  private

  attr_accessor :file, :file_lines, :games_log

  def valid?(line)
    line[/^(.)\1{1,}$/].nil?
  end

  def match_began?(line)
    !line.nil? && line[/InitGame:/]
  end

  def remove_time(line)
    line.gsub(/^((\s{1,2}\d{1,2})|(\d{1,3}))((:)|(\s{1,2})\d{1,2}:)(\d{1,2}\s)/, '')
  end
end

