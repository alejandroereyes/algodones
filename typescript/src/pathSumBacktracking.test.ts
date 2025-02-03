import { Node } from './node'
import { PathSumBacktracking } from './pathSumBacktracking'

const buildPathSumTree = (): Node => {
    const root = new Node(4)
    const left = new Node(2)
    const right = new Node(7)
    root.left = left
    root.right = right
    left.left = new Node(1)
    left.right = new Node(3)
    right.left = new Node(6)
    right.right = new Node(9)

    return root
}

describe('.call', () => {
    it('return true when target sum is found', () => {
        const root = buildPathSumTree()
        const psb = new PathSumBacktracking(root, 17)
        expect(psb.call()).toBeTruthy()
    })

    it('returns false when target sum not found', () => {
        const root = buildPathSumTree()
        const psb = new PathSumBacktracking(root, 99)
        expect(psb.call()).toBeFalsy()  
    })
})