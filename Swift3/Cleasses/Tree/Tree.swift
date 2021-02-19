//
//  Tree.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/3/1.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import Foundation

//struct Tree<Element> {
//    var list: [Element]
//
//}


//struct Tree {
//    var list: [Int]
//
//    mutating
//
//}

//class Tree {
//    private var list: [Int] = []
//
//    init?(_ count: Int, rootNode: Int) {
//        if count == 0 {
//            return nil
//        }
//        self.list = Array(repeating: 0, count: count)
//        self.list[0] = rootNode
//        super.init()
//    }
//
//    func searchNode(_ index: Int) -> Int? {
//        if index < 0 || index >= list.count { return nil }
//        return list[index]
//    }
//
//    func addNode(_ pNodeIndex: Int, direction: Int, node: Int) -> Bool {
//        if index < 0 || index >= list.count { return false }
//
//    }
//}


class Tree {
    enum Direction {
        case lift,right
    }

    private var node: Node = Node()

    func searchNode(_ index: Int) -> Node? {
        return node.searchNode(index)
    }

    func preorder() {
        node.preorder()
    }

    func inorder() {
        node.inorder()
    }

    func postorder() {
        node.postorder()
    }

    @discardableResult
    func add(_ index: Int, direction: Direction, node: Node) -> Bool {
        guard let currentNode = searchNode(index) else { return false }
        node.pNode = currentNode
        switch direction {
        case .lift:
            currentNode.lNode = node
        case .right:
            currentNode.rNode = node
        }
        return true
    }

    @discardableResult
    func delete(_ index: Int) -> Bool {
        guard let currentNode = searchNode(index) else { return false }

        currentNode.delete()
        return true
    }

    deinit {
        print("Tree")
    }
}

class Node: NSObject {
    var index: Int = 0
    var data: Int = 0
    weak var pNode: Node?
    weak var lNode: Node?
    weak var rNode: Node?

    func searchNode(_ index: Int) -> Node? {
        if index == self.index {
            return self
        }
        if let lResult = lNode?.searchNode(index) {
            return lResult
        }
        if let rResult = rNode?.searchNode(index) {
            return rResult
        }
        return nil
    }

    func delete() {
        lNode?.delete()
        rNode?.delete()
        if let pNode = pNode {
            if let plNode = pNode.lNode, plNode == self {
                pNode.lNode = nil
            }
            if let prNode = pNode.rNode, prNode == self {
                pNode.rNode = nil
            }
        }
//        pNode = nil
    }

    func preorder() {
        print(index)
        lNode?.preorder()
        rNode?.preorder()
    }

    func inorder() {
        lNode?.inorder()
        print(index)
        rNode?.inorder()
    }

    func postorder() {
        lNode?.postorder()
        rNode?.postorder()
        print(index)
    }

    deinit {
        print("Node: \(index)")
    }
}

