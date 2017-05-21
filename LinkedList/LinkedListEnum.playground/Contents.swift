import Foundation

enum LinkedList<T> {
    indirect case node(T, LinkedList<T>)
    case end
    
    func forEach(till endIndex: Int? = 0, block: (_ leftNode: inout LinkedList<T>, _ rightNode: inout LinkedList<T>?, _ index: Int) -> Void) {
        var cursor = 0
        var leftNode = self
        var rightNode: LinkedList<T>?
        if case .node(_, let node) = leftNode {
            rightNode = node
        }
        
        while rightNode != nil && (endIndex! > 0 && cursor < endIndex!) {
            block(&leftNode, &rightNode, cursor)
            cursor += 1
            leftNode = rightNode!
            switch leftNode {
            case .end: rightNode = nil
            case .node(_, let node): rightNode = node
            }
        }
    }
    
    private func traverse(to index: Int) -> LinkedList? {
        var head: LinkedList? = self
        var current = 0
        while head != nil, current < index  {
            if case .node(_, let next) = head! {
                head = next
                current += 1
            } else {
                break
            }
        }
        
        if current != index {
            return nil
        }
        
        return head!
    }
    
    func description() -> String {
        var result = ""
        switch self {
        case .end:
            return result
            
        case .node(let value, let next):
            result.append(String(describing: value) + " | ")
            result.append(next.description())
        }
        
        return result
    }
    
    func descriptionReversed() -> String {
        var result = ""
        switch self {
        case .end:
            return result
            
        case .node(let value, let next):
            result.append(next.descriptionReversed())
            result.append(String(describing: value) + " | ")
        }
        
        return result
    }
    
    subscript(index: Int) -> LinkedList<T> {
        get {
            guard let node = traverse(to: index) else {
                fatalError("Index \(index) out of lists bounds")
            }
            return node
        }
    }
    
    mutating func insert(_ value: T) {
        self = .node(value, self)
    }
    
    
    
    mutating func insert(_ value: T, after index: Int) {
        
    }
    
}


var l = LinkedList<Int>.node(7, .end)
l.insert(8)
l.insert(9)
//print()
print(l.description())
l.insert(99, after: 1)
print(l.description())

l.forEach(till: 2) { (left, right, index) in
    print("[\(index)] Left: \(left) \n Right: \(String(describing: right))")
}

