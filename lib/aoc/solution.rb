# frozen_string_literal: true

require_relative 'input'

module AoC
  module Solution
    def run(input_filename = nil)
      input = read_input(input_filename)
      parsed = parse(input)

      puts one(parsed)
      puts two(parsed)
    end

    def day = 0

    def read_input(filename = nil)
      return AoC::Input.read(day) unless filename

      File.read filename
    end

    def parse(input)
      raise NotImplementedError
    end

    def one(parsed)
      raise NotImplementedError
    end

    def two(parsed)
      raise NotImplementedError
    end
  end
end
