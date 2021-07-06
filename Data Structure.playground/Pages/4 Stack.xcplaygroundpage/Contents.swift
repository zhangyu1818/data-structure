class Stack<T> {
    private var values = [T]()

    var top: Int? { isEmpty ? nil : values.count }

    var isEmpty: Bool { values.count == 0 }

    func push(_ value: T) {
        values.append(value)
    }

    func pop() -> T? {
        isEmpty ? nil : values.removeLast()
    }
}

func fact(_ value: Int) -> Int {
    if value == 0 {
        return 1
    }
    return value * fact(value - 1)
}

print(fact(5))
