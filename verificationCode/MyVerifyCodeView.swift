//
//  MyVerifyCodeView.swift
//  verCodeDemo
//
//  Created by sam on 2017/6/15.
//  Copyright © 2017年 sam. All rights reserved.
//

import UIKit

class MyVerifyCodeView: UIView {
    private let charArr = ["0","1","2","3","4","5","6","7","8","9","a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    private var codeCount:Int = 0;
    private var disturbLineCount:Int = 0;
    private var fontSize:CGFloat = 0;
    private(set) var codeString:String = "";

    init(frame: CGRect,codeCount:Int = 4,disturbLineCount:Int = 10,fontSize:CGFloat = 20) {
        super.init(frame: frame);
        self.codeCount = codeCount;
        self.disturbLineCount = disturbLineCount;
        self.fontSize = fontSize;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 验证输入的和验证码是否相等
    @discardableResult
    func verify(code:String) -> Bool {
        return code.uppercased() == self.codeString.uppercased()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()!
        context.clear(rect)
        context.setFillColor(UIColor.randCGColor)
        context.fill(rect)
        self.codeString = ""
        
        let charWidth = self.bounds.width / CGFloat(codeCount)
        let paragraphStyle = NSMutableParagraphStyle()
        
        //画文字
        for i in 0..<codeCount {
            let attrs = [
                NSFontAttributeName: UIFont.systemFont(ofSize: self.fontSize),
                NSParagraphStyleAttributeName: paragraphStyle,
                NSForegroundColorAttributeName: UIColor.randUIColor]
            let index = Int(arc4random_uniform(UInt32(charArr.count)))
            let char = charArr[index]
            char.draw(at: CGPoint(x: charWidth * CGFloat(i) + (charWidth - self.fontSize) * 0.5, y: (rect.height - self.fontSize) * 0.5), withAttributes: attrs)
            self.codeString += char;
        }
        //画干扰线
        context.setLineWidth(1)
        let w = self.bounds.width
        let h = self.bounds.height
        
        for _ in 0..<disturbLineCount {
            context.setStrokeColor(UIColor.randCGColor)
            context.move(to: CGPoint.randPoint(w: w, h: h))
            context.addLine(to: CGPoint.randPoint(w: w, h: h))
            context.strokePath()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.setNeedsDisplay()
    }
}

fileprivate extension UIColor{
    class var randUIColor: UIColor {
        let r = Float(arc4random_uniform(256)) / 255.0
        let g = Float(arc4random_uniform(256)) / 255.0
        let b = Float(arc4random_uniform(256)) / 255.0
        return UIColor(colorLiteralRed: r, green: g, blue: b, alpha: 1)
    }
    class var randCGColor: CGColor {
        return UIColor.randomColor.cgColor
    }
}
fileprivate extension CGPoint{
    static func randPoint(w:CGFloat,h:CGFloat)->CGPoint{
        let x = CGFloat(arc4random_uniform(UInt32(w)))
        let y = CGFloat(arc4random_uniform(UInt32(h)))
        return CGPoint(x: x, y: y)
    }
}
