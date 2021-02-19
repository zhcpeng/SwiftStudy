//
//  ScrollTextViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 16/11/15.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

import UIKit

import SnapKit

class ScrollTextViewController: UIViewController {
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.gray
        scrollView.isScrollEnabled = false
        
        let upSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(upSwipeAction(_:)))
        upSwipe.direction = .up
        scrollView.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(downSwipeAction(_:)))
        downSwipe.direction = .down
        scrollView.addGestureRecognizer(downSwipe)
        
        return scrollView
    }()
    
    fileprivate lazy var contentView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0, alpha: 0)
        view.isUserInteractionEnabled = false
        return view
    }()
    fileprivate var contentViewHightConstraint: Constraint? = nil
    
    fileprivate lazy var titlLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "程序的扩展性很好，好处多多。但是呢，MVC也有它自身的缺陷，那就是控制器太臃肿。"
        label.preferredMaxLayoutWidth = kScreenWidth - 20
        label.backgroundColor = UIColor.blue
        return label
    }()
    
    fileprivate lazy var textLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "在说具体解决思路前，先给大家简单复习一下MVC和MVVM,因为今天的主题也是和MVVM有关系。MVC模式大家都很熟悉了，就是Model,View,Controller三层，Model负责数据层，Controller负责业务逻辑层，View负责界面显示层，Model和View通过Controller来实现桥接交互，程序的扩展性很好，好处多多。但是呢，MVC也有它自身的缺陷，那就是控制器太臃肿，如果你想在控制器中定位某一个点是比较麻烦的事。"
        label.preferredMaxLayoutWidth = kScreenWidth - 20
        label.backgroundColor = UIColor.brown
        return label
    }()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            contentViewHightConstraint = make.height.equalTo(100).constraint
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
        }
        contentView.addSubview(titlLabel)
        contentView.addSubview(textLabel)
        titlLabel.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(contentView).inset(UIEdgeInsets.init(top: 10, left: 10, bottom: 0, right: 10))
        }
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titlLabel.snp.bottom).offset(10)
            make.left.bottom.right.equalTo(contentView).inset(UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10))
        }
        
    }
    
    
    var maxHeight :CGFloat = 100
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let height = self.scrollView.contentSize.height
        maxHeight = height < 100 ? 100 : height
    }
    
    @objc func upSwipeAction(_ gest:UISwipeGestureRecognizer) {
        self.contentViewHightConstraint?.update(offset:self.maxHeight)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) 
    }
    
    @objc func downSwipeAction(_ gest:UISwipeGestureRecognizer) {
        self.contentViewHightConstraint?.update(offset: 100)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
