//
//  KuGouViewController.swift
//  Swift4
//
//  Created by zhcpeng on 2021/1/12.
//  Copyright © 2021 zhcpeng. All rights reserved.
//

import UIKit

import CommonCrypto
import CryptoKit

class KuGouViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        if let url = Bundle.main.url(forResource: "lrc", withExtension: "json") {
//            if let data = try? Data(contentsOf: url) {
//                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
//                    if let dict = json as? [String : Any] {
//                        let content = dict["content"] as! String
//
//                        let strData = Data(base64Encoded: content, options: Data.Base64DecodingOptions(rawValue: 0))
//
////                        let str = NSString(data: strData!, encoding: 0)
//
//
//                        let s = String(data: strData!, encoding: String.Encoding.ascii)
//
//                        print(s)
//
//                    }
//                }
//            }
//        }
        
        let s = signature()
        print(s)
    }
    
    
    func signature() -> String {
        let dict: [String : Any] =
            ["area_code": "1",
             "clienttime": "1613649009976",
             "clientver": "20000",
             "dfid": "-",
             "iscorrection": "7",
             "keyword": "如梦令",
             "mid": "1613649009976",
             "page": "1",
             "pagesize": "20",
             "platform": "WebFilter",
             "srcappid": "2919",
             "tag": "em",
             "userid": "35800134",
             "uuid": "1613649009976"
            ]
        let string = dict.toKeyOrderedValueString()
        
        
        let md5 = string.md5()
        
        let s = Insecure.MD5.hash(data: string.data(using: .utf8)!)
        
        print(s.self)
        if let ss = s as? String {
            print(ss)
        }
        
        return md5
    }
}

/*
 
 
 // 搜索
 signature?
 http://complexsearch.kugou.com/v2/search/song?area_code=1&clienttime=1613649009976&clientver=20000&dfid=-&iscorrection=7&keyword=%E5%A6%82%E6%A2%A6%E4%BB%A4&mid=1613649009976&page=1&pagesize=20&platform=WebFilter&signature=a9f94cb4b575c4ac233ce18e56a79292&srcappid=2919&tag=em&userid=35800134&uuid=1613649009976
 
 // 获取hash
 post
 http://kmr.service.kugou.com/v2/album_audio/audio
 {"data":[{"album_audio_id":0,"audio_id":0,"hash":"714540851E73FA8B82D1A17AB4D9FC1D"}],"appid":1155,"mid":"282a5567f5d51c4a548c4a2dfac572ea","clientver":300,"clienttime":1613649057836,"key":"fb1f87ca27fbebbc2ebe297e67ac1447"}
 
 // 搜索歌词
 http://lyrics.kugou.com/search?client=pc&duration=0&hash=&keyword=%E8%90%A8%E9%A1%B6%E9%A1%B6%20-%20%E5%B7%A6%E6%89%8B%E6%8C%87%E6%9C%88&lrctxt=1&man=no&uid=&ver=1
 
 
 // 下载歌词
 http://lyrics.kugou.com/download?ver=1&client=pc&fmt=lrc&charset=utf8&accesskey=38ECB99BED31DF5F3856A0E917F12583&id=39253671


 
 {
     "content": "77u\/W2lkOiQwMDAwMDAwMF0NClthcjrokKjpobbpobZdDQpbdGk65bem5omL5oyH5pyIXQ0KW2J5Ol0NCltoYXNoOjcyMzM2OGI1OGUwOTgxMGJiZDQ4ZGI4YzFlMWYyZmJkXQ0KW2FsOl0NCltzaWduOl0NCltxcTpdDQpbdG90YWw6MjMwNTMwXQ0KW29mZnNldDowXQ0KWzAwOjAwLjg1XeiQqOmhtumhtiAtIOW3puaJi+aMh+aciA0KWzAwOjAxLjYxXeS9nOivje+8muWWu+axnw0KWzAwOjAxLjc2XeS9nOabsu+8muiQqOmhtumhtg0KWzAwOjI1LjAwXeW3puaJi+aPoeWkp+WcsA0KWzAwOjI3LjcyXeWPs+aJi+aPoeedgOWkqQ0KWzAwOjMxLjcyXeaOjOe6ueijguWHuuS6hg0KWzAwOjMzLjg5XeWNgeaWueeahOmXqueUtQ0KWzAwOjM3LjQyXeaKiuaXtuWFiSDljIbljIblhZHmjaLmiJDkuoblubQNClswMDo0My45NF3kuInljYPkuJYg5aaC5omA5LiN6KeBDQpbMDA6NTEuMjhd5bem5omL5ouI552A6IqxIOWPs+aJi+iInuedgOWJkQ0KWzAwOjU3LjgwXeeciemXtOiQveS4i+S6hiDkuIDkuIflubTnmoTpm6oNClswMTowMy42N13kuIDmu7Tms6og5ZWK5ZWK5ZWKDQpbMDE6MTAuMjRd6YKj5piv5oiRIOWViuWViuWVig0KWzAxOjQzLjk0XeW3puaJi+S4gOW8ueaMhyDlj7PmiYvlvLnnnYDlvKYNClswMTo1MC40MF3oiJ\/mpavmkYbmuKHlnKjlv5jlt53nmoTmsLTpl7QNClswMTo1Ni4yMV3lvZPng6bmgbwg6IO95byA5Ye65LiA5py157qi6I6yDQpbMDI6MDIuODhd6I6r5YGc5q2HIOe7meaIkeadguW\/tQ0KWzAyOjEwLjI5XeW3puaJi+aMh+edgOaciCDlj7PmiYvlj5bnuqLnur8NClswMjoxNi42OV3otZDkuojkvaDlkozmiJHlpoLmhL\/nmoTmg4XnvJgNClswMjoyMi41NV3mnIjlhYnkuK0g5ZWK5ZWK5ZWKDQpbMDI6MjkuMDdd5L2g5ZKM5oiRIOWViuWViuWVig0KWzAyOjQ5LjczXeW3puaJi+WMluaIkOe+vSDlj7PmiYvmiJDps57niYcNClswMjo1Ni4yMF3mn5DkuJblnKjkupHkuIog5p+Q5LiW5Zyo5p6X6Ze0DQpbMDM6MDEuOTJd5oS\/6ZqP5L2gIOeUqOS4gOeykuW+ruWwmOeahOaooeagtw0KWzAzOjA4LjQ5XeWcqOaJgOaciSDlsJjkuJbmta7njrANClswMzoxNS44Ml3miJHlt6bmiYvmi7\/otbfkvaAg5Y+z5omL5pS+5LiL5L2gDQpbMDM6MjIuNTBd5ZCI5o6M5pe2IOS9oOWFqOmDqOiiq+aUtuWbnuW\/g+mXtA0KWzAzOjI4LjIyXeS4gOeCt+mmmSDllYrllYrllYoNClswMzozNC44M13kvaDmmK\/miJENClswMzozNy44Ml3ml6Dkuozml6DliKsNCg==",
     "info": "OK",
     "status": 200,
     "charset": "utf8",
     "fmt": "lrc"
 }
 
 
 // base64 解码
 https://base64.us/
 

 */



extension Dictionary where Key == String, Value == Any {
    func toKeyOrderedValueString(separator: String = "") -> String {
        var stringDictionary: [String: Any] = [:]
        for (key, value) in self {
            stringDictionary[key] = value
        }
        let sortedKeys = stringDictionary.keys.sorted()
        let values = sortedKeys.map { key -> String in
            if let value = stringDictionary[key] {
                return "\(value)"
            }
            return ""
        }
        return values.joined(separator: separator)
    }
}

extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate()
 
        return String(format: hash as String)

    }
}
