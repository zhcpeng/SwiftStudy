//
//  NameSpace.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/7/26.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import Foundation

/// 类型协议
public protocol TypeWrapperProtocol {
    associatedtype WrappedType
    var wrappedVale: WrappedType { get }
    init(value: WrappedType)
}

public struct NameSpaceWrapper<T>: TypeWrapperProtocol {
    public let wrappedVale: T
    public init(value: T) {
        self.wrappedVale = value
    }
}

/// 命名空间协议
public protocol NameSpaceWrappable {
    associatedtype Warppable
    var xcar: Warppable { get }
    static var xcar: Warppable.Type { get }
}
public extension NameSpaceWrappable {
    var xcar: NameSpaceWrapper<Self> {
        return NameSpaceWrapper(value: self)
    }
    static var xcar: NameSpaceWrapper<Self>.Type {
        return NameSpaceWrapper.self
    }
}


/// 具体声明
extension UIView: NameSpaceWrappable {}
extension TypeWrapperProtocol where WrappedType == UIView {
    func add(_ superView: UIView) -> UIView {
        superView.addSubview(wrappedVale)
        return wrappedVale
    }
}


