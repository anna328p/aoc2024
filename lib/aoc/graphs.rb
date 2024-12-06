# frozen_string_literal: true

module AoC
  module Graphs

    def reconstruct_path(prev:, target:)
      s = []
      u = target

      while u
        s.unshift(u)
        u = prev[u]
      end
    end

    def dijkstra(source:, target:, graph:, weight_fn:, neighbors_fn:)
      q = graph

      dist = Hash.new(Float::INFINITY)
      prev = {}

      dist[source] = 0

      until q.empty?
        u = q.min_by { dist[_1] }

        break if u == target

        q.delete(u)

        neighbors_fn.call(u).filter { q.include?(_1) }.each do |v|
          alt = dist[u] + weight_fn.call(u, v)
          if alt < dist[v]
            dist[v] = alt
            prev[v] = u
          end
        end
      end

      reconstruct_path(prev:, target:)
    end

    def bellman_ford() end

    def a_star() end
  end
end
