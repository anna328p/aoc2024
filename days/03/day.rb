# frozen_string_literal: true

require 'aoc'

module Day3
  extend AoC::Solution

  def self.day = 3

  def self.parse(input)
    input
  end

  def self.one(parsed)
    parsed.scan(/mul\((\d+),(\d+)\)/).map { |a, b| a.to_i * b.to_i }.sum
  end

  def self.two(parsed)
    status = true
    parsed.scan(/(mul\((\d+),(\d+)\)|do\(\)|don't\(\))/).map { |ins, a, b|
      case ins
      when "don't()"
        status = false
        0
      when 'do()'
        status = true
        0
      else
        status ? (a.to_i * b.to_i) : 0
      end
    }.sum
  end
end

if (input_filename = ARGV[0])
  Day3.run(input_filename)
else
  Day3.run
end
