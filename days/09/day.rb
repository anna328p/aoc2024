# frozen_string_literal: true

require 'aoc'

module Day9
  extend AoC::Solution

  def self.day = 9

  def self.parse(input)
    input.strip.chars.map(&:to_i)
  end

  def self.one(parsed)
    # preallocate max possible amount
    disk = [nil] * 200_000

    pos = 0
    file_id = 0

    type = :file

    parsed.each do |entry|
      # pp(entry:, type:)

      if type == :file
        entry.times do |i|
          disk[pos + i] = file_id
        end

        file_id += 1
      end

      pos += entry
      type = type == :file ? :free : :file
    end

    ptr_tail = pos - 1
    ptr_head = 0

    debug = false

    loop do
      if debug
        disk[0...pos].each do |entry|
          print entry.nil? ? '.' : entry
        end
        puts "\n#{' ' * ptr_head}^#{' ' * (ptr_tail - ptr_head - 1)}^"
        pp(at_head: disk[ptr_head], at_tail: disk[ptr_tail])
        puts
      end

      unless disk[ptr_head].nil?
        ptr_head += 1
        next
      end

      if disk[ptr_tail].nil?
        ptr_tail -= 1
        next
      end

      break if ptr_head >= ptr_tail

      disk[ptr_head] = disk[ptr_tail]
      disk[ptr_tail] = nil

      ptr_head += 1
      ptr_tail -= 1

      break if ptr_head >= ptr_tail
    end

    disk.each_with_index.sum { |entry, idx| entry.nil? ? 0 : entry * idx }
  end

  Entry = Data.define(:type, :size, :id)

  def self.two(parsed)
    # preallocate max possible amount
    disk = []

    file_id = 0
    type = :file

    parsed.each do |entry|
      # pp(entry:, type:)

      if type == :file
        disk << Entry.new(:file, entry, file_id)
        file_id += 1
      else
        disk << Entry.new(:free, entry, nil)
      end

      type = type == :file ? :free : :file
    end

    ptr_tail = disk.size - 1

    until ptr_tail <= 0
      if disk[ptr_tail].type == :free
        ptr_tail -= 1
        next
      end

      success = false
      (0..ptr_tail).each do |ptr_head|
        break if ptr_head >= ptr_tail
        next if disk[ptr_head].type == :file

        if disk[ptr_head].size == disk[ptr_tail].size
          disk[ptr_head] = disk[ptr_tail]
          disk[ptr_tail] = Entry.new(:free, disk[ptr_tail].size, nil)
          ptr_tail -= 1
          success = true
          break
        elsif disk[ptr_tail].size < disk[ptr_head].size
          remaining_space = disk[ptr_head].size - disk[ptr_tail].size
          tmp = disk[ptr_tail]
          disk[ptr_tail] = Entry.new(:free, disk[ptr_tail].size, nil)
          disk[ptr_head, 1] = [tmp, Entry.new(:free, remaining_space, nil)]
          success = true
          break
        end
      end

      ptr_tail -= 1 unless success
    end

    final_disk = [nil] * 200_000
    pos = 0

    disk.each do |entry|
      if entry.type == :file
        entry.size.times do |i|
          final_disk[pos + i] = entry.id
        end
      end

      pos += entry.size
    end

    final_disk.each_with_index.sum { |entry, idx| entry.nil? ? 0 : entry * idx }
  end
end

if (input_filename = ARGV[0])
  Day9.run(input_filename)
else
  Day9.run
end
