//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let string  = "sjahkjahs_dk"
var list = string.components(separatedBy: "_")
let value = list.last ?? "1.0"
let quality: CGFloat = CGFloat(Double(value) ?? 1.0)
