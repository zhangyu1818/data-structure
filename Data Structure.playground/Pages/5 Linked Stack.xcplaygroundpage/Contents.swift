class StackNode<T> {
    var data: T
    var next: StackNode<T>?
    init(data: T, next: StackNode<T>? = nil) {
        self.data = data
        self.next = next
    }
}

class LinkedStack<T> {
    private var head: StackNode<T>?
    var top: StackNode<T>? { head }
    var isEmpty: Bool { top == nil }

    func push(_ data: T) {
        let newNode = StackNode(data: data, next: head)
        head = newNode
    }

    func pop() -> T? {
        let data = head?.data
        head = head?.next
        return data
    }
}

func isMatchBrackets(_ string: String) -> Bool {
    let stack = LinkedStack<Character>()
    for char in string {
        if char == "(" {
            stack.push(char)
        } else if char == ")" {
            let node = stack.pop()
            if node == nil {
                return false
            }
        }
    }
    return stack.isEmpty
}

print(isMatchBrackets("(a(b(c)d)a)"))

func isPalindrome(_ string: String) -> Bool {
    let stack = LinkedStack<Character>()
    let leftString = string.dropLast(string.count / 2)
    let rightString = string.dropFirst(string.count / 2)
    for char in leftString { stack.push(char) }
    for char in rightString {
        if char != stack.pop() { return false }
    }
    return true
}

print(isPalindrome("1234321"))
