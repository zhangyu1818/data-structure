class Node<T> {
    var value: T
    var next: Node<T>?
    init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
}

class CircularLinkedList<T> {
    private var head: Node<T>? // head is last node
    var first: Node<T>? { head?.next }
    var last: Node<T>? { head }

    func append(_ value: T) {
        let newNode = Node(value: value, next: head?.next)
        if head == nil {
            newNode.next = newNode
            head = newNode
        } else {
            head!.next = newNode
            head = newNode
        }
    }
}

let linkedList = CircularLinkedList<Int>()

linkedList.append(1)
linkedList.append(2)
linkedList.append(3)
