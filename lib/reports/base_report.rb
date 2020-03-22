# frozen_string_literal: true

require 'json'

# Basic implementation of games reports
# Exporting the results into a file .json
class BaseReport
  attr_accessor :path, :content, :filename

  def initialize(content)
    @filename = "#{report_name}-#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.json"
    @path = "lib/reports/generated/#{filename}"
    @content = content
  end

  def self.perform(games)
    content = games.map do |game|
      report_content(game)
    end

    new(content).export
  end

  def export
    File.open(path, 'w+') { |f| f.write(JSON.pretty_generate(content)) }
    "report #{filename} created! \n in: #{path}"
  end

  private

  def report_content(_game = {})
    raise NotImplementedError
  end

  def report_name
    raise NotImplementedError
  end
end
