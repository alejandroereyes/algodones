require 'path_sum_backtracking'
require 'node'

RSpec.describe PathSumBacktracking do

  describe '.call' do
    subject { described_class.call(root, target) }
    let(:root) do
      Node.new(4).tap do |root|
        l2_left = Node.new(2)
        l2_right = Node.new(2)
        root.left = l2_left
        root.right = l2_right
        
        l3_left = Node.new(1)
        l3_right= Node.new(8)    
        l3_right_left = Node.new(3)
        l2_left.left = l3_left
        l2_left.right = l3_right
        l2_right.left = l3_right_left

        l3_left.left = Node.new(2)
        l3_left.right = Node.new(5)

        l3_right.left = Node.new(4)
        l3_right.right = Node.new(3)
        l3_right_left.left = Node.new(2)
        l3_right_left.right = Node.new(8)
      end
    end
   

    context 'when target is within tree' do
      let(:target) { 11 }

      it 'returns the target path' do
        expect(subject).to eq [4, 2, 3, 2]        
      end
    end

    context 'when target is not within tree' do
      let(:target) { 99 }

      it 'returns an empty array' do
        expect(subject).to be_empty
      end
    end
  end
end