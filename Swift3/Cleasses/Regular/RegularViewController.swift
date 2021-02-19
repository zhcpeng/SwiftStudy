//
//  RegularViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/8/28.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

class RegularViewController: UIViewController {

    private var emoticonRegex: NSRegularExpression = try! NSRegularExpression(pattern: "\\#.*?\\#", options: [])
//    private var emoticonRegex: NSRegularExpression = try! NSRegularExpression(pattern: "#(?:\\u[ed][0-9a-f]{3}|[^#])*#", options: [])
    private var text: String = "#121##👫"
    private var emojiText = "123 \t中国😀😀😀👨‍⚕️‍👨‍⚕️‍👫💑👨‍👩‍👧‍👦"
    // utf8 utf16
    private var emoji1 = "👨‍👩‍👧‍👦" // 25 11
    private var emoji2 = "国" // 3 1
    private var emoji3 = "👨‍⚕️" // 4
    private var emoji4 = "😀" // 4 2
    private var emoji5 = "a"
    
//    private var emojiRegex: NSRegularExpression = try! NSRegularExpression(pattern: "\\#.*?|[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]\\#", options: [])
    private var emojiRegex: NSRegularExpression = try! NSRegularExpression(pattern: "[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]", options: [])

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
//        let length = text.unicodeScalars.count
//        let count  = text.count
//        let x = text.utf8.count
//
//        let xx : NSString = "👨‍👩‍👧‍👦" as NSString
//        print(xx.length)


//        let matches = emoticonRegex.matches(in: text, options: [], range: NSRange(location: 0, length: text.characters.count))
//        if !matches.isEmpty {
//            for one in matches {
////                if one.range.length > 3 && one.range.length < 23
//                print(one)
//            }
//        }
//        
//        for x in emojiText.unicodeScalars {
////            let xx = x.value
//            print(x.value)
//            print(x.escaped(asASCII: true))
//        }
//        
////        let ss = Emoji.MultiEmojiRegex.matches(in: emojiText, options: [], range: NSRange.init(location: 0, length: emojiText.characters.count))
////        for sss in ss {
////            print(sss)
////        }
//
//        let x = emojiRegex.matches(in: text, options: [], range: NSRange.init(location: 0, length: emojiText.characters.count))
//        for xx in x {
//            print(xx)
//        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
