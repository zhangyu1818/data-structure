class Node<T> {
    var value: T
    var next: Node<T>?
    var prior: Node<T>?
    init(value: T, prior: Node<T>? = nil, next: Node<T>? = nil) {
        self.value = value
        self.prior = prior
        self.next = next
    }
}

class DoublyLinkedList<T> {
    private var head: Node<T>?
    var first: Node<T>? { head }
    var last: Node<T>? { head?.prior }

    func append(_ value: T) {
        let newNode = Node(value: value)
        if let lastNode = last, let firstNode = first {
            newNode.next = lastNode.next
            newNode.prior = lastNode
            lastNode.next = newNode
            firstNode.prior = newNode
        } else {
            newNode.prior = newNode
            newNode.next = newNode
            head = newNode
        }
    }

    func append<R: Sequence>(range: R) where R.Element == T {
        for value in range {
            append(value)
        }
    }

    func insert(at index: Int, value: T) {
        guard let node = at(index) else { return }
        let newNode = Node(value: value, prior: node.prior, next: node)
        node.prior!.next = newNode
        node.prior = newNode
        if node === head { head = newNode }
    }

    func remove(at index: Int) {
        guard let node = at(index) else { return }
        node.prior!.next = node.next
        node.next!.prior = node.prior
        if node === head { head = node.next }
    }

    func at(_ index: Int) -> Node<T>? {
        guard var node = head else { return nil }
        var i = 0
        while let next = node.next {
            if i == index { break }
            i += 1
            if next === head { return nil }
            node = next
        }
        return node
    }

    func forEach(_ cb: (T) -> Void) {
        guard var node = head else { return }
        while let next = node.next {
            cb(node.value)
            if next === first { return }
            node = next
        }
    }
}

let linkedList = DoublyLinkedList<Int>()

linkedList.append(range: 0 ..< 10)

linkedList.insert(at: 0, value: 10)
linkedList.remove(at: 0)

linkedList.forEach { print($0) }
