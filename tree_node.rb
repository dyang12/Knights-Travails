class TreeNode
  attr_accessor :parent, :value
  attr_reader :children

  def initialize(value, parent_node=nil)
    @parent = parent_node
    @value = value
    @children = []
    parent_node.add_child(self) if parent_node
  end

  def left=(new_node)
    raise "You can't use left with more than two children" if children.length > 2
    children[0].parent = nil if children[0]
    children[0] = new_node
  end

  def right=(new_node)
    raise "You can't use right with more than two children" if children.length > 2
    children[1].parent = nil if children[1]
    children[1] = new_node
  end

  def add_child(new_node)
    children << new_node
  end

  def dfs(target = nil, &prc)
    dfs_results = dfs_array(target, &prc).compact
    return nil if dfs_results.empty?
    dfs_results[0]
  end

  def dfs_array(target, &prc)
    if block_given?
      return [self] if prc.call(value) == true
    else
      return [self] if value == target
    end

    all_search = []

    unless children.empty?
      children.each do |child|
        all_search.concat(child.dfs_array(target, &prc))
      end
    end

    return [nil] if all_search.empty?
    all_search
  end

  def bfs(target = nil, &prc)
    current_nodes = [self]

    until current_nodes.empty?
      current_node = current_nodes.shift

      if block_given?
        return current_node if prc.call(current_node.value) == true
      else
        return current_node if current_node.value == target
      end

      current_nodes.concat(current_node.children)
    end

    nil
  end
end