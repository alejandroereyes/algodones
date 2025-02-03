class Node
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
  end

  def leaf?
    left.nil? && right.nil?
  end
end

def build_tree
  Node.new(3).tap do |root|
    child_l = Node.new(9)
    child_r = Node.new(20)
    grand_child_r_l = Node.new(15)
    grand_child_r_r = Node.new(7)
    grand_child_l_l = Node.new(33)
    child_r.left = grand_child_r_l
    child_r.right = grand_child_r_r
    child_l.left = grand_child_l_l
    root.right = child_r
    root.left = child_l
  end
end


module DepthFirst
  extend self

  def call(node, target)
    return unless node
    return node.val if node.val == target

    left = call(node.left, target)
    return left if left
    
    call(node.right, target)
  end
end

module BreathFirst
  extend self

  def call(node, target, queue = nil)
    return unless node
    queue ||= [node]

    node = queue.shift
    return node.val if node.val == target

    [node.left, node.right].each do |child|
      queue << child if child
    end

    call(node, target, queue)
  end
end

class PathSumAllBacktracking

  def self.call(root, target)
    @cache = Set.new

    backtrack(root, target)

    @cache
  end

  def self.backtrack(node, target, path = [])
    return unless node
    path << node.val

    if node.leaf? && path.sum == target
      @cache << path
    else
      backtrack(node.left, target, path.dup)
      backtrack(node.right, target, path.dup)
    end
  end
end

def build_path_sum_all_tree
  Node.new(1).tap do |root|
    left = Node.new(2)
    right = Node.new(4)
    root.left = left
    root.right = right

    left.left = Node.new(4)
    left.right = Node.new(7)
    right.left = Node.new(5)
    right.right = Node.new(1)
  end
end

class HelloBacktracking

  GRID = [
    ['B', 'L', 'C', 'H'],
    ['D', 'E', 'L', 'T'],
    ['D', 'A', 'K', 'A'],
  ].freeze

  GRID_2 = [
    ['B', 'L', 'C', 'H'],
    ['D', 'E', 'L', 'T'],
    ['D', 'A', 'X', 'A'],
    ['D', 'K', 'T', 'A'],
  ].freeze

  GRID_3 = [
    ['B', 'L', 'C', 'H'],
    ['D', 'E', 'L', 'T'],
    ['K', 'A', 'X', 'A'],
    ['D', 'I', 'T', 'A'],
  ].freeze

  def initialize(board, target)
    @board = board
    @total_rows = board.length
    @total_cols = board[0].length
    @target = target
    @path = []
    @word = ''
  end

  def self.call(board, target)
    new(board, target).call
  end

  def call
    @total_rows.times do |current_row|
      @total_cols.times do |current_col|

        if a_match?(current_row, current_col, 0)
          if search(current_row, current_col, 0)
            return true
          end
        end
     
      end
    end
    
    false
  end

  def a_match?(row, col, index)
    @board[row][col] == @target[index]
  end

  def search(row, col, index)
    # if we get to # of characters + 1,
    #  it means we weren't kicked out by not matching
    #  and recursively called search after we found the last character
    return true if index == @target.length
    return false if out_of_bounds?(row, col) || !a_match?(row, col, index)

    char = @board[row][col].dup
    # temporally "hide" cells we have already visited while down this current path
    @board[row][col] = '_'

    # search adjacent cells for next char
    found = begin
      search(row + 1, col, index + 1) ||
        search(row - 1, col, index + 1) ||
        search(row, col + 1, index + 1) ||
        search(row, col - 1, index + 1)
    end

    # return cell to normal for another path to check
    @board[row][col] = char
    found
  end

  def out_of_bounds?(row, col)
    out_of_bound_rows?(row) ||
      out_of_bound_cols?(col)
  end

  def out_of_bound_rows?(row)
    row < 0 || row >= @total_rows
  end

  def out_of_bound_cols?(col)
    col < 0 || col >= @total_cols
  end
end

@hb = HelloBacktracking.new(HelloBacktracking::GRID, 'BLEAK')
@hb2 = HelloBacktracking.new(HelloBacktracking::GRID, 'NOT')


class AllPossibleSetsBacktracking
  
  def initialize(nums)
    @nums = nums
    @result = []
    @path = []
  end

  def call
    backtrack(0)
    @result
  end

  def backtrack(index)
    if index == @nums.length
      @result << @path.dup
      return
    end

    # empty case
    backtrack(index + 1)

    # with elements case
    @path << @nums[index]
    backtrack(index + 1)
    @path.pop
  end
end

@all = AllPossibleSetsBacktracking.new([1, 2, 3])

# Neg Diagonal 
#  row increase by 1
#  col increase by 1
# (row - col) each gets constant per diag

# Pos Diagonal
#  row decrease by 1
#  col increase by 1
#  (row + col) each gets constant per diag

class NQueens

  def initialize(size)
    @size = size
    @used_cols = Set.new
    @pos_diags = Set.new
    @neg_diags = Set.new
    @result = []
    @board = size.times.map { [:_] * size }
  end

  def self.call(size)
    new(size).call
  end

  def call
    backtrack(0)
    @result
  end

  def backtrack(row)
    if row == @size
      @result << @board.map(&:join)
      return
    end

    @size.times do |col|
      next if captured_space?(row, col)

      track(row, col)
      
      backtrack(row + 1)

      untrack(row, col)
    end
  end

  def captured_space?(row, col)
    @used_cols.include?(col) ||
      @pos_diags.include?(row + col) ||
      @neg_diags.include?(row - col)
  end

  def track(row, col)
    @used_cols << col
    @pos_diags << row + col
    @neg_diags << row - col
    @board[row][col] = :Q 
  end

  def untrack(row, col)
    @used_cols.delete(col)
    @pos_diags.delete(row + col)
    @neg_diags.delete(row - col)
    @board[row][col] = :_
  end
end

@nq = NQueens.new(8)