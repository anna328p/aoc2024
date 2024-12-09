# frozen_string_literal: true

require 'aoc'

module Day7
  extend AoC::Solution

  def self.day = 7

  def self.parse(input)
    l = input.lines.map(&:strip)
    l.map { a, b = _1.split(': '); [a.to_i, b.split(' ').map(&:to_i)] }
  end

  def self.blerp((first, *rest), ops)
    ops.zip(rest).reduce(first) { |a, (op, b)| a.send(op, b) }
  end

  # TODO: incorrect answer!
  def self.one(parsed)

    parsed.count { |target, values|
      op_seqs = %i[+ *].repeated_permutation(values.size - 1)
      op_seqs.any? { |ops| blerp(values, ops) == target }
    }
  end

  def self.two(parsed)

  end
end

if (input_filename = ARGV[0])
  Day7.run(input_filename)
else
  Day7.run
end
