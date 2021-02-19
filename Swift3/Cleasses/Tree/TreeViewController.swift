//
//  TreeViewController.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/3/1.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import UIKit

/// 自定义 树
class TreeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tree = Tree()

        let node1 = Node()
        node1.index = 1
        node1.data = 5

        let node2 = Node()
        node2.index = 2
        node2.data = 8

        let node3 = Node()
        node3.index = 3
        node3.data = 2

        let node4 = Node()
        node4.index = 4
        node4.data = 6

        let node5 = Node()
        node5.index = 5
        node5.data = 9

        let node6 = Node()
        node6.index = 6
        node6.data = 7

        let node7 = Node()
        node7.index = 7
        node7.data = 231

        tree.add(0, direction: .lift, node: node1)
        tree.add(0, direction: .right, node: node2)

        tree.add(1, direction: .lift, node: node3)
        tree.add(1, direction: .right, node: node4)

        tree.add(2, direction: .lift, node: node5)
        tree.add(2, direction: .right, node: node6)

        tree.add(3, direction: .lift, node: node7)

        tree.preorder()
//        tree.inorder()
//        tree.postorder()

        print("aaaa")
        tree.delete(2)
        tree.preorder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
