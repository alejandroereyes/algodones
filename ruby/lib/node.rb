class Node
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
  end

  def leaf?
    left.nil? && right.nil?
  end
end