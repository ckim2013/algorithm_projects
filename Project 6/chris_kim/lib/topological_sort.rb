require_relative 'graph'
require 'byebug'
# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  # byebug
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
    #
    # current_node.out_edges.each do |edge|
    #   # Need to figure out how to loop while deleting
    #   neighbor = edge.to_vertex
    #   edge.destroy!
    #
    #   if neighbor.in_edges.empty?
    #     top_queue.push(neighbor)
    #   end
    # end
  end

  sorted
end
