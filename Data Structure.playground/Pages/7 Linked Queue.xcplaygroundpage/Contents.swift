class LinkedQueue<T> {
    class Node {
        var value: T
        var next: Node?
        init(value: T, next: Node? = nil) {
            self.value = value
            self.next = next
        }
    }

    private var head: Node?
    private var rear: Node?
    private var size: Int
    private var length = 0
    var count: Int { length }

    init(size: Int) {
        self.size = size
    }

    convenience init() {
        self.init(size: Int.max)
    }

    var isEmpty: Bool { length == 0 }
    var isFull: Bool { length == size }

    func enQueue(_ value: T) {
        if isFull { return }
        let node = Node(value: value)
        if head == nil { head = node }
        if let rearNode = rear {
            rearNode.next = node
        }
        rear = node
        length += 1
    }

    func deQueue() -> T? {
        if isEmpty { return nil }
        guard let node = head else { return nil }
        head = node.next
        node.next = nil
        length -= 1
        return node.value
    }
}

let queue = LinkedQueue<Int>(size: 4)

for i in 1 ... 4 {
    queue.enQueue(i)
}

for _ in 1 ... 4 {
    print(queue.deQueue()!)
}

queue.enQueue(1)
queue.enQueue(2)
queue.enQueue(3)
queue.enQueue(4)

print(queue.deQueue()!)
print(queue.deQueue()!)

queue.enQueue(5)
queue.enQueue(6)

print(queue.deQueue()!)
print(queue.deQueue()!)
print(queue.deQueue()!)
print(queue.deQueue()!)
