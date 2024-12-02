# frozen_string_literal: true

require 'aoc'

module Day2
  extend AoC::Solution

  def self.day = 2

  def self.parse(input)
    input.lines.map { _1.split.map(&:to_i) }
  end

  def self.one(parsed)
    parsed.filter { |l| predicate(l) }.size
  end

  def self.predicate(l)
      c = l.each_cons(2)
      c.reduce(true) { |acc, (a, b)| acc && a <= b && (a - b).abs.between?(1, 3)}  \
      || c.reduce(true) { |acc, (a, b)| acc && a >= b && (a - b).abs.between?(1, 3) } 
  end

  def self.two(parsed)
    parsed
      .map { |a|
        (a.combination(a.size - 1).to_a + [a])
          .map { |l| predicate(l) }
      }
      .filter(&:any?)
      .size
  end
end

if (input_filename = ARGV[0])
  Day2.run(input_filename)
else
  Day2.run
end
