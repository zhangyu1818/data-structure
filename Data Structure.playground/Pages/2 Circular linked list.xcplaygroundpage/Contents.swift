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

    func append<R: Sequence>(range: R) where R.Element == T {
        for value in range {
            append(value)
        }
    }

    func forEach(_ cb: (T) -> Void) {
        guard var node = first else { return }
        while let next = node.next {
            cb(node.value)
            node = next
            if node === first {
                return
            }
        }
    }
}

extension CircularLinkedList where T: Comparable {
    /**
     根据value值比较后按顺序插入链表
     */
    func insert(value: T) {
        guard var node = first else { return }
        let newNode = Node(value: value)
        while let next = node.next {
            if next === first || next.value > value { break }
            node = next
        }
        newNode.next = node.next
        node.next = newNode
        if node === last {
            head = newNode
        }
    }
}

let linkedList = CircularLinkedList<Int>()

linkedList.append(range: 0 ..< 10)

linkedList.insert(value: 5)
linkedList.insert(value: 10)

linkedList.forEach { print($0) }
