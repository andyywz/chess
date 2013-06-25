class TreeNode
  attr_accessor :parent, :value, :children
  
  def initialize(value, parent = nil)
    self.value = value
    self.parent = parent
    @children = []
  end
  
  def add_child(child)
    @children << child
    child.parent = self
  end
  
  def dfs(target = 0, &block)
    if block_given?
      return self if yield(self.value)
      return nil if @children == []
      @children.each do |child|
        child_node = child.dfs(&block)
        unless child_node.nil?
          return child_node if yield(child_node.value)
        end
      end

    else
      return self if target == @value
      return nil if @children == []
      @children.each do |child|
        child_node = child.dfs(target)
        unless child_node.nil?
          return child_node if child_node.value == target
        end
      end
    end
    
    nil
  end
  
  def bfs(target = 0, &block)
    unchecked_nodes = [self]
    
    until unchecked_nodes.empty?
      unchecked_node = unchecked_nodes.shift
      if block_given?
        return unchecked_node if yield(unchecked_node.value)
      else
        return unchecked_node if unchecked_node.value == target
      end
      unchecked_nodes += unchecked_node.children
    end
    
    nil
  end
end

root = TreeNode.new(1)
root.add_child(TreeNode.new(2))
root.add_child(TreeNode.new(3))
root.add_child(TreeNode.new(4))
a = root.children[0]
b = root.children[1]
c = root.children[2]
a.add_child(TreeNode.new(5))
a.add_child(TreeNode.new(6))
c.add_child(TreeNode.new(7))
d = a.children[0]
e = a.children[1]
f = c.children[0]

p root.dfs {|num| num > 3} == d
p root.bfs {|num| num > 5} == e