# frozen_string_literal: true

require 'aoc/input'

input = AoC::Input.read(1)
lines = input.lines.map(&:strip)

ints = lines.map(&:to_i)

lists = lines.map{ |l| l.split.map(&:to_i) }.transpose.map(&:sort)

l, r = *lists

counts = r.tally

puts l.map { _1 * (counts[_1]||0) }.sum
