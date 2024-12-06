# frozen_string_literal: true

require 'aoc'
require 'matrix'

module Day6
  extend AoC::Solution

  def self.day = 6

  def self.parse(input)
    input.lines.map { |l| l.strip.chars }
  end

  def self.turn_right(dir)
    {
      up: :right,
      right: :down,
      down: :left,
      left: :up
    }[dir]
  end

  def self.dir_to_offset(dir)
    {
      up: Vector[0, -1],
      right: Vector[1, 0],
      down: Vector[0, 1],
      left: Vector[-1, 0]
    }[dir]
  end

  def self.one(parsed)
    visited = Hash.new(false)

    y = parsed.find_index { |l| l.include?('^') }
    x = parsed[y].index('^')

    pos = Vector[x, y]

    dir = :up
    
    loop do
      visited[pos] = true

      next_pos = pos + dir_to_offset(dir)

      break if parsed[next_pos[1]].nil?

      in_front = parsed[next_pos[1]][next_pos[0]]
      break if in_front.nil?

      if in_front == '#'
        dir = turn_right(dir)
        next
      end

      break \
        unless pos[0].between?(0, parsed[0].size - 1) \
          && pos[1].between?(0, parsed.size - 1)

      pos = next_pos
    end

    visited.values.count
  end

  # WARNING: VERY SLOW, 6m40s on my laptop
  def self.two(parsed_)
    init_y = parsed_.find_index { |l| l.include?('^') }
    init_x = parsed_[init_y].index('^')

    init_pos = Vector[init_x, init_y]

    loops = {}

    parsed_.size.times do |ny|
      parsed_[0].size.times do |nx|
        visited = Hash.new(false)

        new_obstacle_pos = Vector[nx, ny]

        dir = :up
        pos = init_pos

        parsed = parsed_.map(&:dup)
        parsed[ny][nx] = '#'

        loop do

          visited[[pos, dir]] = true

          next_pos = pos + dir_to_offset(dir)

          if visited[[next_pos, dir]]
            loops[new_obstacle_pos] = true
            break
          end

          break if parsed[next_pos[1]].nil?

          in_front = parsed[next_pos[1]][next_pos[0]]
          break if in_front.nil?

          if in_front == '#'
            dir = turn_right(dir)
            next
          end

          break \
            unless pos[0].between?(0, parsed[0].size - 1) \
              && pos[1].between?(0, parsed.size - 1)

          pos = next_pos
        end

      end
    end

    loops.values.count
  end
end

if (input_filename = ARGV[0])
  Day6.run(input_filename)
else
  Day6.run
end
