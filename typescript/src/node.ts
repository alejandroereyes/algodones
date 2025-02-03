export class Node {
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
