//: Playground - noun: a place where people can play

import UIKit


//let c = "\u{E9}"
//print(c.count)


//let list = [Int](count:5, repeatedValue: 10)


//let i = arc4random_uniform(100)


//let s = NSProcessInfo()
//s.hostName
//s.physicalMemory


//let ssss = "12345678"
//var result = ""
//var temp = ssss
//let nums = ssss.characters.count / 3
//for _ in 0..<nums {
//    result = "," + temp.substringFromIndex(temp.endIndex.advancedBy(-3)) + result
//    temp = temp.substringToIndex(temp.endIndex.advancedBy(-3))
//}
//if ssss.characters.count % 3 != 0 {
//    result = temp + result;
//} else {
//    if nums != 0{
//        result = result.substringFromIndex(result.startIndex.advancedBy(1))
//    }
//}
//print(result)


//var xxx = pow(3.0, 3.0)


//var string = "111"
//let c1 = { [string] in
//    print(string)
//}
//let c2 = {
//    print(string)
//}
//string = "222"
//c1()
//c2()
//
//class AAAA {
//    var string = "1111111111111"
//    lazy var c1 = { [string] in
//        print(string)
//    }
//    lazy var c2 = {
//        print(self.string)
//    }
//    deinit {
//        print("AAA deinit")
//    }
//}
//
//struct BBBB {
//    var string = "BBB"
//}
//
//var b: BBBB? = BBBB()
//let d4 = { [b] in
//    print(b?.string ?? "non")
//}
//b!.string = "BB"
////d4()
//b = nil
//d4()
//b?.string
//let e = b
//
//var aa: AAAA? = AAAA()
//aa!.string
//let c3 = { [weak aa] in
//    print(aa?.string ?? "aa 不存在")
//}
//aa!.string = "2"
//
////aa!.c1()
////aa!.c2()
//c3()
//aa = nil


//let r1 = rint(0.5)
//let r2 = rint(1.5)


//let i1: Int = -100
//let i2: UInt = UInt.init(bitPattern: i1)
//let i3 = Int.init(bitPattern: i2)
//let ss1 = i2.bitWidth


//struct Point {
////    let isx: Bool
////    let isFilled: Bool
//    let x: Double
////    let isFilled: Bool
//    let y: Double
////    let isFilled: Bool
//    let isx: Bool
//    let isFilled: Bool
//}
//MemoryLayout<Point>.size == 17
//MemoryLayout<Point>.stride == 24
//MemoryLayout<Point>.alignment == 8
//let msize = MemoryLayout<Point>.size
//let mstride = MemoryLayout<Point>.stride
//let ma = MemoryLayout<Point>.alignment
//let sA = MemoryLayout<AAAA>.size


//class DDD {
//    var d: String
//    var dddd: String = "Super" {
//        didSet{
//            print("super")
//        }
//    }
//
//    init(_ d: String) {
//        self.d = d
//    }
//}
//class DDDD: DDD {
//    var dd: String {
//        didSet{
//            print("dd")
//        }
//    }
//    init(_ d: String, dd: String) {
//        self.dd = dd
//        super.init(d)
//        dddd = "dd"
//        self.dd = "d"
//    }
//}
//let x = DDDD.init("ddddddd", dd: "dddddd")


//let age = -3
////assert(age > 0, "age ")
//precondition(age > 0, "Index must be greater than zero.")


//var a: Int8 = 5
//var bb: Int8 = a &* 100
//var cc = Int8.max
//var dd = bb % 127


//let a: Bool = (3, "apple") > (3, "abird")
//let bb: Bool = ("apple", 3) > ("abird", 3)
//let a: Bool = (1,2,3,4,5,6) < (1,2,3,4,5,6)


//let a = ...5


//let a:String = "한"
//let bb: NSString = "한"
//print(a.count)
//print(bb.length)


//let dogString = "Dog‼🐶"
//for x in dogString {
//    print(x)
//}
//for x in dogString.utf8 {
//    print(x)
//}


//var a = 1
//repeat {
//    a += 1
//} while a < 1
//a


//func stepForward(_ input: inout Int) -> Int {
//    input += 1
//    return input
//}
//func stepBackward(_ input: inout Int) -> Int {
//    input -= 1
//    return input
//}
//func chooseStepFunction(backward: Bool) -> (inout Int) -> Int {
//    return backward ? stepBackward : stepForward
//}
//var currentValue = 3
//let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
//moveNearerToZero(&currentValue)
//currentValue
//
//chooseStepFunction(backward: currentValue > 0)(&currentValue)
//currentValue


//var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
//print(customersInLine.count)
//// Prints "5"
//
//let customerProvider = { customersInLine.remove(at: 0) }
//print(customersInLine.count)
//// Prints "5"
//
//print("Now serving \(customerProvider())!")
//// Prints "Now serving Chris!"
//print(customersInLine.count)
//// Prints "4"


//indirect enum ArithmeticExpression {
//    case number(Int)
//    case addition(ArithmeticExpression, ArithmeticExpression)
//    case multiplication(ArithmeticExpression, ArithmeticExpression)
//}
//let five = ArithmeticExpression.number(5)
//let four = ArithmeticExpression.number(4)
//let sum = ArithmeticExpression.addition(five, four)
//let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
//func evaluate(_ expression: ArithmeticExpression) -> Int {
//    switch expression {
//    case let .number(value):
//        return value
//    case let .addition(left, right):
//        return evaluate(left) + evaluate(right)
//    case let .multiplication(left, right):
//        return evaluate(left) * evaluate(right)
//    }
//}
//print(evaluate(product))


//let a: Int? = 6
//var b: Int = 0
//a.map({ b = $0 })
//print(b) // 6


//let a = CGFloat.leastNonzeroMagnitude
//let b = CGFloat.leastNormalMagnitude
//let c = a < b


//var stepSize = 1
//func incrementInPlace(_ number: inout Int) {
//    number += stepSize
//}
//incrementInPlace(&stepSize)
//print(stepSize)


//var i = 5
//i += i
//print(i)


//func balance(_ x: inout Int, _ y: inout Int) {
//    let sum = x + y
//    x = sum / 2
//    y = sum - x
//}
//var playerOneScore = 41
//var playerTwoScore = 30
//balance(&playerOneScore, &playerTwoScore)  // OK
//
////balance(&playerOneScore, &playerOneScore)
//print("\(playerOneScore)... \(playerTwoScore)")


//struct Player {
//    var health: Int
//
//    static let maxHealth = 10
//    mutating func restoreHealth() {
//        health = Player.maxHealth
//    }
//}
//
//var p = Player.init(health: 5)
//p.restoreHealth()
//print(p.health)


//struct Vector2D {
//    var x = 0.0, y = 0.0
//}
//infix operator +-: AdditionPrecedence
//extension Vector2D {
//    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
//        return Vector2D(x: left.x + right.x, y: left.y - right.y)
//    }
//}
//let firstVector = Vector2D(x: 1.0, y: 2.0)
//let secondVector = Vector2D(x: 3.0, y: 4.0)
//let plusMinusVector = firstVector +- secondVector
//// plusMinusVector is a Vector2D instance with values of (4.0, -2.0)


//class HTMLElement {
//    let name: String
//    let text: String?
//    lazy var asHTML: Void -> String = {
//        [unowned self] in
//        if let text = self.text {
//            return "<\(self.name)>\(text)</\(self.name)>"
//        } else {
//            return "<\(self.name) />"
//        }
//    }
//
//    init(name: String, text: String? = nil) {
//        self.name = name
//        self.text = text
//    }
//
//    deinit {
//        print("\(name) is being deinitialized")
//    }
//}

/// 会产生内存泄露
//class HTMLElement {
//    let name: String
//    let text: String?
//    lazy var asHTML: () -> String = {
//        if let text = self.text {
//            return "<\(self.name)>\(text)</\(self.name)>"
//        } else {
//            return "<\(self.name) />"
//        }
//    }
//
//    init(name: String, text: String? = nil) {
//        self.name = name
//        self.text = text
//    }
//    deinit {
//        print("\(name) is being deinitialized")
//    }
//}
//var x: HTMLElement? = HTMLElement.init(name: "111")
////x!.asHTML = {
////    return "222"
////}
//print(x!.asHTML())
//x = nil

//class AA {
//    let a: String
//    let b: String?
//
//    lazy var c: () -> String = { [unowned self] in
//        if let b = self.b {
//            return b
//        } else {
//            return "C"
//        }
//    }
//
//    lazy var d: String = {
//        return "d"
//    }()
//
//    init(a: String, b: String? = nil) {
//        self.a = a
//        self.b = b
//    }
//    deinit {
//        print("AA deinit")
//    }
//}

//var a: AA? = AA.init(a: "aaaaa")
////print(a!.c())
//print(a!.d)
//a = nil


//func aplusb(a: Int, b: Int) -> Int {
//    var a = a
//    var b = b
//    while b != 0 {
//        let _a = a ^ b
//        let _b = (a & b) << 1
//        a = _a
//        b = _b
//    }
//    return a
//}
//aplusb(a: 5000, b: 100000)


//func average(a: Int, b: Int) -> Int {
//    let res = a & b + (a ^ b) >> 1
//    return res
//}
//average(a: 11, b: 20)


//let b = String(30, radix: 16)
//let t = Int(b)


//func binary2dec(num:String) -> Int {
//    var sum = 0
//    for c in num {
//        sum = sum << 1 + Int("\(c)")!
//    }
//    return sum
//}
//binary2dec(num: "11111")


//func subSets(_ nums: [Int]) -> [[Int]] {
//    var result: [[Int]] = []
//    let n = nums.count
//    var array = nums.sorted()
//    for i in 0..<(1 << n) {
//        var subSet = [Int]()
//        for j in 0..<n where (i & (1 << j)) != 0 {
//            subSet.append(nums[j])
//        }
//        result.append(subSet)
//    }
//    return result
//}
//let x = subSets([10,10,11])
//print(x)


//func unique(_ nums: [Int]) -> [Int] {
//    if nums.isEmpty { return [] }
//    let nums = nums.sorted()
//    var dict = [Int : Int]()
//    var result: [Int] = []
//    for item in nums {
//        if dict[item] == nil {
//            result.append(item)
//            dict[item] = item
//        }
//    }
//    return result
//}
//print(unique([1,2,3,4,3,5,2,1]))


//class Tree {
//    enum Direction {
//        case lift,right
//    }
//
//    private var node: Node = Node()
//
//    func searchNode(_ index: Int) -> Node? {
//        return node.searchNode(index)
//    }
//
//    func preorder() {
//        node.preorder()
//    }
//
//    func inorder() {
//        node.inorder()
//    }
//
//    func postorder() {
//        node.postorder()
//    }
//
//    @discardableResult
//    func add(_ index: Int, direction: Direction, node: Node) -> Bool {
//        guard let currentNode = searchNode(index) else { return false }
//        node.pNode = currentNode
//        switch direction {
//        case .lift:
//            currentNode.lNode = node
//        case .right:
//            currentNode.rNode = node
//        }
//        return true
//    }
//
//    @discardableResult
//    func delete(_ index: Int) -> Bool {
//        guard let currentNode = searchNode(index) else { return false }
//        currentNode.delete()
//        return true
//    }
//
//    deinit {
//        print("Tree")
//    }
//}
//
//class Node {
//    var index: Int = 0
//    var data: Int = 0
//    weak var pNode: Node?
//    weak var lNode: Node?
//    weak var rNode: Node?
//
//    func searchNode(_ index: Int) -> Node? {
//        if index == self.index {
//            return self
//        }
//        if let lResult = lNode?.searchNode(index) {
//            return lResult
//        }
//        if let rResult = rNode?.searchNode(index) {
//            return rResult
//        }
//        return nil
//    }
//
//    func delete() {
//        lNode?.delete()
//        rNode?.delete()
//        if let pNode = pNode {
//            if let plNode = pNode.lNode, plNode.index == self.index {
//                pNode.lNode = nil
//            }
//            if let prNode = pNode.rNode, prNode.index == self.index {
//                pNode.rNode = nil
//            }
//        }
//    }
//
//    func preorder() {
//        print(index)
//        lNode?.preorder()
//        rNode?.preorder()
//    }
//
//    func inorder() {
//        lNode?.inorder()
//        print(index)
//        rNode?.inorder()
//    }
//
//    func postorder() {
//        lNode?.postorder()
//        rNode?.postorder()
//        print(index)
//    }
//
//    deinit {
//        print("Node: \(index)")
//    }
//}
//
//let tree = Tree()
//
//let node1 = Node()
//node1.index = 1
//node1.data = 5
//
//let node2 = Node()
//node2.index = 2
//node2.data = 8
//
//let node3 = Node()
//node3.index = 3
//node3.data = 2
//
//let node4 = Node()
//node4.index = 4
//node4.data = 6
//
//let node5 = Node()
//node5.index = 5
//node5.data = 9
//
//let node6 = Node()
//node6.index = 6
//node6.data = 7
//
//let node7 = Node()
//node7.index = 7
//node7.data = 231
//
//tree.add(0, direction: .lift, node: node1)
//tree.add(0, direction: .right, node: node2)
//
//tree.add(1, direction: .lift, node: node3)
//tree.add(1, direction: .right, node: node4)
//
//tree.add(2, direction: .lift, node: node5)
//tree.add(2, direction: .right, node: node6)
//
//tree.add(3, direction: .lift, node: node7)
//
//let node11 = Node()
//node11.data = 951
//node11.index = 11
//tree.add(5, direction: .lift, node: node11)
//
//tree.preorder()
////        tree.inorder()
////        tree.postorder()
//
//print(" ")
//tree.delete(5)
//tree.preorder()



func insertsort( _ list: inout [Int]) {
    for i in 1..<list.count {
        let temp = list[i]
        var j = i - 1
        while j >= 0 && list[j] > temp {
            list[j + 1] = list[j]
            j = j - 1
        }
        list[j + 1] = temp
    }
}

var temp = [7,1,3,6,4]
insertsort(&temp)


//func quickSort(_ list: inout [Int]) {
//
//}
//
//func indi



func quick3Way<T>(_ list: inout [T]) where T: Comparable {
    quick3Way(&list, low: 0, high: list.count - 1)
}

func quick3Way<T>(_ list: inout [T], low: Int, high: Int) where T: Comparable {
    if low >= high { return }
    var lt = low
    var i = low + 1
    var gt = high
    let v = list[low]
    while i <= gt {
        if list[i] < v {
            exchange(&list, l: lt, r: i)
            lt += 1
            i += 1
        } else if list[i] > v {
            exchange(&list, l: i, r: gt)
            gt -= 1
        } else {
            i += 1
        }
    }
    quick3Way(&list, low: low, high: lt - 1)
    quick3Way(&list, low: gt + 1, high: high)
}

func exchange<T>(_ list: inout [T], l: Int, r: Int) {
    let temp = list[l]
    list[l] = list[r]
    list[r] = temp
}

var list: [Int] = [0,1,1,3,1,5,6,5,5,9]
quick3Way(&list)



enum Kind {
    case wolf
    case fox
    case dog
    case sheep
}

struct Animal {
    private var a: Int = 1       //8 byte
    var b: String = "animal"     //24 byte
    var c: Kind = .wolf          //1 byte
    var d: String?               //25 byte
    var e: Int8 = 8              //1 byte

    //返回指向 Animal 实例头部的指针
    mutating func headPointerOfStruct() -> UnsafeMutablePointer<Int8> {
        return withUnsafeMutablePointer(to: &self) {
            return UnsafeMutableRawPointer($0).bindMemory(to: Int8.self, capacity: MemoryLayout<Animal>.stride)
        }
    }

    func printA() {
        print("Animal a:\(a)")
    }
}

var animal = Animal()
let animalPtr: UnsafeMutablePointer<Int8> = animal.headPointerOfStruct()
let intValueFromJson = 100

//将之前得到的指向 animal 实例的指针转化为 rawPointer 指针类型，方便我们进行指针偏移操作
var animalRawPtr = UnsafeMutableRawPointer(animalPtr)
// UnsafeMutablePointer
let aPtr = animalRawPtr.advanced(by: 0).assumingMemoryBound(to: Int.self)
aPtr.pointee          // 1
animal.printA()       //Animal a: 1
aPtr.initialize(to: intValueFromJson)
aPtr.pointee          // 100
animal.printA()       //Animal a:100


//let a[5] = [1, 2, 3, 4, 5];
//let *ptr = (Int *)(&a + 1);
//printf("%d, %d", *(a + 1), *(ptr + 1));


