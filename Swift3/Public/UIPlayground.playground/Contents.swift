//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//class A : NSObject {
//    var name: String {
//        return NSStringFromClass(A.self)
//    }
//}
//
//class B : A {
//    override var name: String {
//        return NSStringFromClass(B.self)
//    }
//}

//let b = B()
//print(b.name)
//
//
//let x = NSClassFromString(b.name)
//print(x!)

//print(2)
//
//func bezierPathCorners(_ view: UIView) {
//    view.sizeToFit()
//    let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .bottomRight, cornerRadii: CGSize(width: 50, height: 50))
//    let maskLayer = CAShapeLayer()
//    maskLayer.frame = view.bounds
//    maskLayer.path = maskPath.cgPath
//    view.layer.mask = maskLayer
//}
//
//
//let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//view.backgroundColor = UIColor.red
//bezierPathCorners(view)
//view
//
//
//print(1)



class A: NSObject {
    static let `default` = A()
}


class B : NSObject {
    let a = A.default

    deinit {
        print("\(#function)")
    }
}

var b: B? = B()
let a = b
b = nil
let c = b


