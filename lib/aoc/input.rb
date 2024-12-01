# frozen_string_literal: true

require 'pathname'

module AoC
  module Input
    def self.read(day)
      input_path = Pathname.new("#{__dir__}/../../data/inputs/#{day}.txt").cleanpath

      File.read(input_path.to_s)
    end

    def self.read!(day)
      read(day)
    rescue Errno::ENOENT
      system("fetch #{day}")
      read(day)
    end
  end
end
