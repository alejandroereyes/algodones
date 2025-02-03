import { Node } from './node'

export class PathSumBacktracking {
    root: Node
    number: number
    path: number[] = []

    constructor(root: Node, number: number) {
        this.root = root
        this.number = number
    }

    call(): boolean {
        return this.backtrack(this.root, 0)
    }

    backtrack(node: Node | undefined, acc: number): boolean {
        if (!node) return false

        this.path.push(node.val)
        acc += node.val

        if (acc > this.number) {
            this.path.pop()
            return false
        }

        if (node.isLeaf() && acc === this.number) return true

        const found = (
            this.backtrack(node.left, acc) ||
            this.backtrack(node.right, acc)
        )
        if (found) return found

        this.path.pop()
        return false
    }
}