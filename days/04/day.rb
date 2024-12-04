# frozen_string_literal: true

require 'aoc'

module Day4
  extend AoC::Solution

  def self.day = 4

  def self.parse(input)
    input.lines.map { |l| l.strip.chars }
  end

  def self.scan_linear(array)
    array.map { |r| r.each_cons(4).count { |c| c.join == 'XMAS' } }.sum
  end

  def self.scan_4x4(array)
    array.each_cons(4).map { |rows|
      rows.transpose.each_cons(4).count { |elems|
        elems.each_with_index.all? { |e, i| e[i] == 'XMAS'[i] }
      }
    }.sum
  end

  def self.scan_3x3(array)
    p1 = <<~PAT.lines.map { |l| l.strip.chars }
      M.S
      .A.
      M.S
    PAT

    p2 = p1.transpose
    p3 = p1.map(&:reverse)
    p4 = p2.reverse

    array.each_cons(3).map { |rows|
      rows.transpose.each_cons(3).map(&:transpose).count { |elems|
        [p1, p2, p3, p4].any? { |pat|
          pat.each_with_index.all? { |p_row, y|
            p_row.each_with_index.all? { |p, x| p == '.' || p == elems[y][x] }
          }
        }
      }
    }.sum
  end

  def self.one(parsed)
    rev = parsed.map(&:reverse)
    transposed = parsed.transpose
    transposed_rev = transposed.map(&:reverse)

    flipped = parsed.reverse
    double_flipped = rev.reverse

    [
      # Scan for XMAS in all directions
      scan_linear(parsed),
      scan_linear(rev),
      scan_linear(transposed),
      scan_linear(transposed_rev),

      # Sliding 4x4 window

      scan_4x4(parsed),
      scan_4x4(rev),
      scan_4x4(flipped),
      scan_4x4(double_flipped)
    ].sum
  end

  def self.two(parsed)
    scan_3x3(parsed)
  end
end

if (input_filename = ARGV[0])
  Day4.run(input_filename)
else
  Day4.run
end
