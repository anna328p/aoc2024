# frozen_string_literal: true

require 'aoc'

module Day1
  extend AoC::Solution

  def self.day = 1

  def self.parse(input)
    input.lines.map { |l| l.split.map(&:to_i) }.transpose.map(&:sort)
  end

  def self.one(lists)
    lists[0].zip(lists[1]).map { |a, b| (a - b).abs }.sum
  end

  def self.two((l, r))
    counts = r.tally

    l.map { _1 * (counts[_1] || 0) }.sum
  end
end

if (input_filename = ARGV[0])
  Day1.run(input_filename)
else
  Day1.run
end
