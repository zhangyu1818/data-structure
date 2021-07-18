class Queue<T> {
    private var queue: [T?]
    private var queueSize: Int

    var count = 0

    private var head = 0
    private var trail: Int { (head + count) % queueSize }

    var isFull: Bool {
        count == queueSize
    }

    var isEmpty: Bool {
        count == 0
    }

    init(queueSize: Int) {
        self.queueSize = queueSize
        queue = [T?](repeating: nil, count: queueSize)
    }

    func enQueue(_ value: T) {
        if isFull { return }
        queue[trail] = value
        count += 1
    }

    func deQueue() -> T? {
        if isEmpty { return nil }
        let value = queue[head]
        head = (head + 1) % queueSize
        count -= 1
        return value
    }
}

let queue = Queue<Int>(queueSize: 4)

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
