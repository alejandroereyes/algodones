import { Node } from './node'

describe('.isLeaf', () => {
    it('returns true when node has no children', () => {
        const node = new Node(1)
        expect(node.isLeaf()).toBeTruthy()        
    })

    it('returns false when node has a single left child', () => {
        const node = new Node(4)
        node.left = new Node(2)
        expect(node.isLeaf()).toBeFalsy()
    })

    it('returns false when node has a single right child', () => {
        const node = new Node(4)
        node.right = new Node(6)
        expect(node.isLeaf()).toBeFalsy()
    })
})