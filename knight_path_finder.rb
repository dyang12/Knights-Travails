require './tree_node.rb'

class KnightPathFinder

  attr_reader :root
  
  def initialize(initial_pos)
    @root = TreeNode.new(initial_pos)
    build_move_tree
  end
  
  def build_move_tree
    visited_positions = [@root.value]
    future_nodes = [@root]
    until future_nodes.empty?
      curr_node = future_nodes.shift
      possible_moves = new_move_positions(curr_node.value).reject do |pos| 
        visited_positions.include?(pos)
      end
      
      possible_moves.each do |pos|
        new_node = TreeNode.new(pos, curr_node)
        visited_positions << pos
        future_nodes << new_node
      end
    end
  end
  
  def new_move_positions(pos)
    possible_moves = []
    
    deltas = [[-2, 1],
              [-1, 2],
              [1, 2],
              [2, 1],
              [2, -1],
              [1, -2],
              [-1, -2],
              [-2, -1]]
    
    deltas.each do |(dx, dy)|
      move = [pos[0] + dx, pos[1] + dy]
      possible_moves << move if in_bounds?(move)
    end
    
    possible_moves
  end
  
  def in_bounds?(pos)
    pos[0] >= 0 && pos[0] < 8 && pos[1] >= 0 && pos[1] < 8
  end
  
  def find_path(ending_pos)
    path = []
    curr_node = @root.bfs(ending_pos)
    
    until curr_node.value == @root.value
      path.unshift(curr_node.value)
      curr_node = curr_node.parent
    end
    
    path.unshift(@root.value)
  end
end

kpf = KnightPathFinder.new([0, 0])