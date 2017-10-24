require_relative 'graph'
require 'byebug'
# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  top_queue = []
  # vertices_hash = {}

  # vertices.each { |vertex| vertices_hash[vertex] = true }

  vertices.each do |vertex|
    if vertex.in_edges.empty?
      top_queue << vertex
    end
  end

  until top_queue.empty?
    current_vertex = top_queue.shift
    sorted << current_vertex

    until current_vertex.out_edges.empty?
      edge = current_vertex.out_edges[0]
      neighbor = edge.to_vertex
      edge.destroy!

      if neighbor.in_edges.empty?
        top_queue.push(neighbor)
      end

    end
    # vertices_hash.delete(current_vertex)
  end

  # vertices_hash.empty? ? sorted : []
  # Or
  sorted.length == vertices.length ? sorted : []
end
