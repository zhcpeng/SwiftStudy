//
//  StretchImageViewController.swift
//  SwiftStudy
//
//  Created by ext.zhangchunp1 on 2023/11/14.
//

import UIKit

class StretchImageViewController: UIViewController {
    
    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange
        
        imageView.backgroundColor = UIColor.red
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        
        self.view.addSubview(imageView)
        
        let toWidth = UIScreen.main.bounds.size.width - 80
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(toWidth)
            make.height.equalTo(100)
        }
        
//        DispatchQueue.global().async {
//            let sem = DispatchSemaphore(value: 0)
//            DispatchQueue.main.async {
//                self.imageView.kf.setImage(with: URL(string: "https://storage.360buyimg.com/cms-activities-img/rigths/v0.png"), completionHandler: { [weak self](image, error, cacheType, imageURL) in
//
//                    print("1111")
//
//                    sem.signal()
//                })
//            }
//
//            DispatchQueue.main.async {
//                self.imageView.kf.setImage(with: URL(string: "https://storage.360buyimg.com/cms-activities-img/rigths/v0.png"), completionHandler: { [weak self](image, error, cacheType, imageURL) in
//
//                    print("2222")
//
//                    sem.signal()
//                })
//            }
//
//
//            sem.wait(timeout: .now() + 5)
//            sem.wait(timeout: .now() + 5)
//            print("END")
//        }
        
        
        self.imageView.kf.setImage(with: URL(string: "https://storage.360buyimg.com/cms-activities-img/rigths/v0.png"), completionHandler: { [weak self](image, error, cacheType, imageURL) in
            guard let image else { return }

            let toWidth = UIScreen.main.bounds.size.width - 80
            let scale = toWidth / image.size.width
            let newHeight = image.size.height * scale
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: toWidth, height: newHeight), false, 3)
            image.draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            guard let i = newImage else { return }
            self?.imageView.image = i.resizableImage(withCapInsets: UIEdgeInsets(top: i.size.height * 0.85 - 1, left: i.size.width / 2 - 1, bottom: i.size.height * 0.15 + 1, right: i.size.width / 2 + 1), resizingMode: .stretch)
            
            let tempH: CGFloat = 300.0 + CGFloat((arc4random() % 100)) * CGFloat((arc4random() % 2 == 0 ? (-1) : 1))
            if tempH < newHeight {
                self?.imageView.contentMode = .top
            } else {
                self?.imageView.contentMode = .scaleToFill
            }
            
            

            self?.imageView.snp.updateConstraints({ make in
                make.height.equalTo(tempH)
            })
        })
        
    }
    

   

}
