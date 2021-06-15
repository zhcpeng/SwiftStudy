//
//  RetinaDrawRectView.swift
//  SwiftStudy
//
//  Created by zhangchunpeng1 on 2021/3/17.
//

import UIKit

class RetinaDrawRectView: UIView {
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func draw(_ rect: CGRect) {
        guard let content = UIGraphicsGetCurrentContext() else { return }
        content.setShouldAntialias(true)
//        content.setLineWidth(1 / UIScreen.main.scale)
//        content.setLineWidth(4)
//        content.setStrokeColor(UIColor.green.cgColor)
        var x: CGFloat = 10
        for i in 0...40 {
            
            content.beginPath()
            
            if i % 2 == 0 {
                content.setLineWidth(5)
                content.setStrokeColor(UIColor.green.cgColor)
                content.move(to: CGPoint(x: x, y: 10.0));
                content.addLine(to: CGPoint(x: x, y: CGFloat(arc4random() % 200) + 10.0))
                content.strokePath()
            } else {
//                content.setLineWidth(1 / UIScreen.main.scale)
                content.setLineWidth(1)
                content.setStrokeColor(UIColor.red.cgColor)
                
                let y = CGFloat(arc4random() % 200) + 10.0
                let cx: CGFloat = 2
                content.move(to: CGPoint(x: x - cx, y: 10))
                content.addLine(to: CGPoint(x: x - cx, y: y))
                content.addLine(to: CGPoint(x: x + cx, y: y))
                content.addLine(to: CGPoint(x: x + cx, y: 10))
                content.addLine(to: CGPoint(x: x - cx, y: 10))
                content.strokePath()
                content.fillPath()
            }
        
            
            
            
//            content.strokePath()
            
            x += 7
            
        }
        
        
    }
    

}
