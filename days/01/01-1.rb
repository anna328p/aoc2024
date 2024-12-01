# frozen_string_literal: true

require 'aoc/input'

input = AoC::Input.read(1)
lines = input.lines.map(&:strip)

ints = lines.map(&:to_i)

lists = lines.map{ |l| l.split.map(&:to_i) }.transpose.map(&:sort)
puts lists[0].zip(lists[1]).map { |a, b| (a - b).abs }.sum
