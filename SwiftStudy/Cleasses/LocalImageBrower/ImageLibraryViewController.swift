//
//  ImageLibraryViewController.swift
//  SwiftStudy
//
//  Created by zhangchunpeng1 on 2021/6/15.
//

import UIKit

class ImageLibraryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate var itemWidth: CGFloat = floor((UIScreen.main.bounds.size.width - 10) / 3)

    fileprivate lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return flowLayout
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: self.flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isDirectionalLockEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ImageLibraryCollectionViewCell.self, forCellWithReuseIdentifier: "ImageLibraryCollectionViewCell")
        return collectionView
    }()
    
    private let paths = NSHomeDirectory() + "/Documents/image"
    private var itemList: [String] = []
//    private var cache: NSCache<NSString, UIImage> = {
//        let cache = NSCache<NSString, UIImage>()
//        
//        return cache
//    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
//        collectionView.contentInsetAdjustmentBehavior = .never
        
        try? itemList = FileManager.default.contentsOfDirectory(atPath: paths)
        if !itemList.isEmpty {
//            itemList.sort()
            itemList = itemList.sorted().reversed()
            print("load success")
            collectionView.reloadData()
        }
        
    }
    
    deinit {
        LocalImageCacheManager.default.cache.removeAllObjects()
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageLibraryCollectionViewCell", for: indexPath) as! ImageLibraryCollectionViewCell
        let path = paths + "/" + itemList[indexPath.row]
        if let image = LocalImageCacheManager.default.cache.object(forKey: path as NSString) {
            cell.image = image
            print("cache:\(indexPath.row)")
        } else {
            let url = URL(fileURLWithPath: path)
            
            if let data = try? Data(contentsOf: url, options: []), let image = UIImage(data: data){
                cell.image = image
                
                LocalImageCacheManager.default.cache.setObject(image, forKey: path as NSString)
//                LocalImageCacheManager.default.cache.setObject(image, forKey: path as NSString, cost: data.count)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = LocalImageBrowerViewController()
        vc.itemList = itemList;
        vc.currentIndex = indexPath.item
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
