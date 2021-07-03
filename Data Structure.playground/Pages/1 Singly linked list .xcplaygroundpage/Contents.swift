public class Node<T> {
    var value: T
    var next: Node<T>?
    init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
}

class LinkedList<T> {
    private var head: Node<T>?
    var first: Node<T>? { head }
    var last: Node<T>? {
        guard var node = head else {
            return nil
        }
        while let next = node.next {
            node = next
        }
        return node
    }

    var isEmpty: Bool { head == nil }

    subscript(index: Int) -> Node<T>? {
        at(index)
    }

    func append(_ value: T) {
        let node = Node(value: value)
        if head == nil {
            head = node
        } else {
            if let lastNode = last {
                lastNode.next = node
            }
        }
    }

    func append<R: Sequence>(range: R) where R.Element == T {
        for value in range {
            append(value)
        }
    }

    func insert(at index: Int, value: T) {
        guard var node = head else { return }
        var i = 0
        while let next = node.next {
            if i < index - 1 {
                node = next
                i += 1
            } else { break }
        }
        let newNode = Node(value: value, next: node.next)
        node.next = newNode
    }

    func insert(after index: Int, value: T) {
        guard let node = at(index) else { return }
        let newNode = Node(value: value, next: node.next)
        node.next = newNode
    }

    func remove(at index: Int) {
        guard var node = head else { return }
        var i = 0
        while let next = node.next {
            if i < index - 1 {
                node = next
                i += 1
            } else { break }
        }
        if let next = node.next {
            node.next = next.next
            next.next = nil
        }
    }

    func at(_ index: Int) -> Node<T>? {
        var node = head
        for _ in 0 ..< index {
            if node == nil { break }
            node = node?.next
        }
        return node
    }

    func at(of value: T) -> Node<T>? where T: Equatable {
        guard var node = head else {
            return nil
        }
        while let next = node.next {
            if node.value == value {
                return node
            }
            node = next
        }
        return nil
    }

    func forEach(_ cb: (T) -> Void) {
        var node = head
        while node != nil {
            cb(node!.value)
            node = node!.next
        }
    }
}

/**
 分别获取index为奇数和偶数的链表
 */
func getOddAndEven<T>(_ linkedList: LinkedList<T>) -> (odd: LinkedList<T>, even: LinkedList<T>) {
    let odd = LinkedList<T>()
    let even = LinkedList<T>()
    var node = linkedList.first

    while node != nil {
        if even.first == nil {
            even.append(node!.value)
            node = node!.next
        } else {
            odd.append(node!.value)
            node = node!.next
            if node != nil {
                even.append(node!.value)
                node = node!.next
            }
        }
    }

    return (odd, even)
}

/**
 合并两条值顺序递增的链表
 */
func mergeLinkedList<T: Comparable>(_ a: LinkedList<T>, _ b: LinkedList<T>) -> LinkedList<T> {
    let mergedList = LinkedList<T>()
    var aNode = a.first
    var bNode = b.first
    while aNode != nil, bNode != nil {
        if aNode!.value < bNode!.value {
            mergedList.append(aNode!.value)
            aNode = aNode!.next
        } else {
            mergedList.append(bNode!.value)
            bNode = bNode!.next
        }
    }
    if let restNode = aNode ?? bNode {
        mergedList.last?.next = restNode
    }
    return mergedList
}

let linkedList = LinkedList<Int>()

linkedList.append(range: 0 ... 10)

linkedList.insert(at: 3, value: -1)
linkedList.remove(at: 3)

let (odd, even) = getOddAndEven(linkedList)

mergeLinkedList(odd, even).forEach { print($0) }
