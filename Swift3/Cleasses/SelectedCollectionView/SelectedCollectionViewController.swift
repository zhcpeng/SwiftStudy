//
//  SelectedCollectionViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/3/31.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

class SelectedCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    fileprivate lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.scrollDirection = .vertical //.horizontal
//        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize //UILayoutFittingExpandedSize
        flowLayout.estimatedItemSize = CGSize(width: 100, height: 32)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(XCRCollectionForumForumNameCell.self, forCellWithReuseIdentifier: "XCRCollectionForumForumNameCell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.contentInset = UIEdgeInsets(top: 6, left: 15, bottom: 6, right: 15)
        collectionView.scrollsToTop = false
        return collectionView
    }()
    
    var itemList: [String] = []
    var selectedIndexPath: IndexPath? = nil {
        didSet{
            if let new = selectedIndexPath {
                let cell = collectionView.cellForItem(at: new) as? XCRCollectionForumForumNameCell
                cell?.showMark = true
            }
            if let old = oldValue {
                let cell = collectionView.cellForItem(at: old) as? XCRCollectionForumForumNameCell
                cell?.showMark = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            for i in 0...10 {
                self.itemList.append("\(i)")
            }
            self.collectionView.reloadData()
            self.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XCRCollectionForumForumNameCell", for: indexPath) as! XCRCollectionForumForumNameCell
        cell.title = itemList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
        selectedIndexPath = indexPath
    }


}


private class XCRCollectionForumForumNameCell: UICollectionViewCell {
    // MARK: - Property
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var showMark: Bool = false {
        didSet{
            theme()
        }
    }
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Method
    fileprivate func commonInit() {
        layer.masksToBounds = true
        layer.borderWidth = 0.5
        layer.cornerRadius = 2
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            make.height.equalTo(32)
        }
    }
    
//    fileprivate override var isSelected: Bool {
//        didSet {
//            theme()
//        }
//    }
    
    // MARK: - Theme
    fileprivate func theme() {
        if showMark {
            backgroundColor = UIColor.blue
            titleLabel.textColor = UIColor.white
        } else {
            backgroundColor = UIColor.white
            titleLabel.textColor = UIColor.blue
        }
    }
}
