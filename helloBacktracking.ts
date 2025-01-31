
class Node {
    val: number;
    left?: Node;
    right?: Node;

    constructor(val: number) {
        this.val = val
    }

    isLeaf(): boolean {
        return !this.left && !this.right
    }
}

const left = new Node(1)
const root = new Node(2)
const right = new Node(3)

root.left = left
root.right = right

const depthFirst = {
    call: function (node: Node | undefined, number: number): number | undefined {
        if (!node) return
        if (node.val === number) return node.val

        this.call(node.left, number) || this.call(node.right, number)
    }
}


const breathFirstSearch = {
    call: function (node: Node, number: number, queue: Node[] = []): number | undefined {
        if (!node) return
        if (!queue[0]) queue.push(node)
        
        const currentNode = queue.shift()
        if (currentNode?.val === number) return currentNode.val

        if (node.left) queue.push(node.left)
        if (node.right) queue.push(node.right)

        this.call(node, number, queue)
    }
}

class PathSumBacktracking {
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

const buildPathSumTree = () => {
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

const psbRoot = buildPathSumTree()
const psb = new PathSumBacktracking(psbRoot, 17)
console.log(psb.call())