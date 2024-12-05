# frozen_string_literal: true

require 'aoc'

module Day5
  extend AoC::Solution

  def self.day = 5

  def self.parse(input)
    a, b = input.split("\n\n")

    rules = a.lines.map { |l| l.strip.split('|').map(&:to_i) }

    updates = b.lines.map { |l| l.strip.split(',').map(&:to_i) }

    [rules, updates]
  end

  def self.mk_maps(rules)
    maps = Hash.new { |h, k| h[k] = [] }

    rules.each do |r|
      maps[r[0]] << r[1]
    end

    maps
  end

  def self.predicate(maps, u)
    u.each_with_index.all? { |pg, i| u[(i + 1)..].all? { maps[pg].include? _1 } }
  end

  def self.one((rules, updates))
    maps = mk_maps(rules)

    updates.filter { |u| predicate(maps, u) }.sum { |u| u[u.size / 2] }
  end

  def self.dfs(graph, remaining_values, stack = [])
    return stack if remaining_values.empty?
return stack + remaining_values if remaining_values.size == 1 && graph[stack.last].include?(remaining_values[0])

    remaining_values.each_with_index do |v, i|
      if stack.any?
        next unless graph[stack.last].include?(v)
      end

      nv = remaining_values.dup
      nv.delete_at(i)

      next unless graph[v].any? { nv.include? _1 }

      res = dfs(graph, nv, stack + [v])
      return res if res
    end

    nil
  end

  # WARNING: incredibly slow, 4m13s on my laptop
  def self.two_((rules, updates))
    maps = mk_maps(rules)

    mismatched = updates.reject { |u| predicate(maps, u) }

    res = mismatched.map { |u| dfs(maps, u) }

    res.sum { |u| u[u.size / 2] }
  end

  def self.two((rules, updates))
    maps = mk_maps(rules)

    mismatched = updates.reject { |u| predicate(maps, u) }

    res = mismatched.map { |u| u.sort { |a, b| maps[a].include?(b) ? 1 : -1 } }

    res.sum { |u| u[u.size / 2] }
  end
end

if (input_filename = ARGV[0])
  Day5.run(input_filename)
else
  Day5.run
end
