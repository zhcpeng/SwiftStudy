//
//  ViewAnimateViewController.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/2/24.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import UIKit

class ViewAnimateViewController: UIViewController {

    private let view1: UIView = UIView()
    private let view2: UIView = UIView()
    private var isHeight: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(view1)
        view.addSubview(view2)

        view1.backgroundColor = UIColor.black
        view2.backgroundColor = UIColor.brown

        view1.frame = CGRect.init(x: 0, y: 100, width: 100, height: 200)
        view2.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(200)
            make.top.equalToSuperview().offset(100)
        }

        let button = UIButton(type: .custom)
        button.setTitle("按钮", for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(UIColor.red), for: .normal)
        view.addSubview(button)
        button.frame = CGRect.init(x: 100, y: 100, width: 200, height: 50)
        button.reactive.controlEvents(.touchUpInside).observeValues({ [weak self](_) in
            self?.buttonChangedAndAnimate()
        })

        let button2 = UIButton(type: .custom)
        button2.setTitle("按钮", for: .normal)
        button2.setBackgroundImage(UIImage.imageWithColor(UIColor.green), for: .normal)
        view.addSubview(button2)
        button2.frame = CGRect.init(x: 100, y: 200, width: 200, height: 50)
        button2.reactive.controlEvents(.touchUpInside).observeValues({ [weak self](_) in
            self?.buttonAnimatingAndChange()
        })


//        ab(a: 5, b: 10)
//        ab8(a: 100, b: 100)

        print(unique([1,2,3,4,3,5,2,1]))
    }

    func buttonChangedAndAnimate() {
        self.isHeight = !self.isHeight
        if self.isHeight {
            self.view1.frame = CGRect.init(x: 0, y: 100, width: 100, height: 400)
            self.view2.snp.updateConstraints({ (make) in
                make.height.equalTo(400)
            })
        } else {
            self.view1.frame = CGRect.init(x: 0, y: 100, width: 100, height: 200)
            self.view2.snp.updateConstraints({ (make) in
                make.height.equalTo(200)
            })
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }

    func buttonAnimatingAndChange() {
        self.isHeight = !self.isHeight
        UIView.animate(withDuration: 0.5, animations: {
            //                self.view.layoutIfNeeded()
            if self.isHeight {
                self.view1.frame = CGRect.init(x: 0, y: 100, width: 100, height: 400)
                self.view2.snp.updateConstraints({ (make) in
                    make.height.equalTo(400)
                })
            } else {
                self.view1.frame = CGRect.init(x: 0, y: 100, width: 100, height: 200)
                self.view2.snp.updateConstraints({ (make) in
                    make.height.equalTo(200)
                })
            }
        })
    }


    func ab(a: Int, b: Int) -> Int {
        var a = a
        var b = b
        while b != 0 {
            let _a = a ^ b
            let _b = (a & b) << 1
            a = _a
            b = _b
        }
        return a
    }

    func ab8(a: Int8, b: Int8) -> Int8 {
        var a = a
        var b = b
        while b != 0 {
            let _a = a ^ b
            let _b = (a & b) << 1
            a = _a
            b = _b
        }
        return a

//        String(0b00001111, radix: 2, uppercase: true)
    }


    func subSets(_ nums: [Int]) -> [[Int]] {
        var result: [[Int]] = []
        let n = nums.count
        let array = nums.sorted()
        for i in 0..<(1 << n) {
            var subSet = [Int]()
            for j in 0..<n where (i & (1 << j)) != 0 {
                subSet.append(array[j])
            }
            result.append(subSet)
        }
        return result
    }


    func unique(_ nums: [Int]) -> [Int] {
        if nums.isEmpty { return [] }
        let nums = nums.sorted()
        var result = [nums[0]]
        for i in 1..<nums.count where nums[i] != result[i - 1] {
            result.append(nums[i])
        }
        return result
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
