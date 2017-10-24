require_relative 'graph'
require 'byebug'
# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []

  top_queue = []

  vertices.each do |vertex|
    if vertex.in_edges.empty?
      top_queue << vertex
    end
  end

  until top_queue.empty?
    current_node = top_queue.pop
    sorted << current_node

    until current_node.out_edges.empty?
      edge = current_node.out_edges[0]
      neighbor = edge.to_vertex
      edge.destroy!

      if neighbor.in_edges.empty?
        top_queue.push(neighbor)
      end

    end
    vertices.delete(current_node)
  end

  vertices.empty? ? sorted : []
end
