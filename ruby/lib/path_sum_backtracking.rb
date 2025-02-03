class PathSumBacktracking
  
  def initialize(root, target)
    @root = root
    @target = target
    @result = []
  end

  def self.call(root, target)
    new(root, target).call
  end

  def call
    backtrack(@root, [], 0)
    @result
  end

  def backtrack(node, path, total)
    return unless node

    path << node.val
    total += node.val

    if total > @target
      path.pop
      return
    end
    
    if node.leaf? && total == @target
      @result = path.dup
    else
      backtrack(node.left, path, total)
      backtrack(node.right, path, total)
    end

    path.pop
  end
end