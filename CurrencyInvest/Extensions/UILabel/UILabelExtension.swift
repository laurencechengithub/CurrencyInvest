//
//  UILabelExtension.swift
//  re
//
//  Created by Laurence  Chen on 2018/8/15.
//  Copyright © 2018 Re Corporation Limited. All rights reserved.
//

import Foundation
import UIKit

class UILabelPadding : UILabel {
    
    var contentInset: UIEdgeInsets = .zero {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }
    
    override func drawText(in rect: CGRect) {
        //super.drawText(in: UIEdgeInsetsInsetRect(rect, contentInset))
        super.drawText(in: rect.inset(by: contentInset))
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height += contentInset.top + contentInset.bottom
        size.width += contentInset.left + contentInset.right
        return size
    }

//    private var padding = UIEdgeInsets.zero
//
//    var insets : UIEdgeInsets = UIEdgeInsets.zero
//
//    func set(text: String, color: UIColor, back: UIColor, padding: Int) {
//        self.backgroundColor = back
//        self.textColor = color
//        self.text = text
//        self.sizeToFit()
//        let f = self.frame
//        self.frame = CGRect(x: 0,
//                            y: 0, width: Int(f.width)+(padding*2),
//                            height: Int(f.height)+(padding*2))
//        insets = UIEdgeInsets(top: CGFloat(padding),
//                              left: CGFloat(padding),
//                              bottom: CGFloat(padding),
//                              right: CGFloat(padding))
//    }
//    override func drawText(in rect: CGRect) {
//
//        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
//    }
    
    
//    @IBInspectable
//    var paddingLeft: CGFloat {
//        get { return padding.left }
//        set { padding.left = newValue }
//    }
//
//    @IBInspectable
//    var paddingRight: CGFloat {
//        get { return padding.right }
//        set { padding.right = newValue }
//    }
//
//    @IBInspectable
//    var paddingTop: CGFloat {
//        get { return padding.top }
//        set { padding.top = newValue }
//    }
//
//    @IBInspectable
//    var paddingBottom: CGFloat {
//        get { return padding.bottom }
//        set { padding.bottom = newValue }
//    }
//
//    override func drawText(in rect: CGRect) {
//        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
//    }
//
//    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
//        let insets = self.padding
//        var rect = super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, insets), limitedToNumberOfLines: numberOfLines)
//        rect.origin.x    -= insets.left
//        rect.origin.y    -= insets.top
//        rect.size.width  += (insets.left + insets.right)
//        rect.size.height += (insets.top + insets.bottom)
//        return rect
//    }
    
}



@IBDesignable
class EdgeInsetLabel: UILabel {
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
//    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
//        let insetRect = UIEdgeInsetsInsetRect(bounds, textInsets)
//        let insetRect = self.bounds.inset(by: bounds)
//        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
//        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
//                                          left: -textInsets.left,
//                                          bottom: -textInsets.bottom,
//                                          right: -textInsets.right)
//        return UIEdgeInsetsInsetRect(textRect, invertedInsets)
//    }
//
//
//
//    override func drawText(in rect: CGRect) {
//        var padding = frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
//        super.drawText(in: UIEdgeInsetsInsetRect(rect, textInsets))
//    }
}

extension EdgeInsetLabel {
    @IBInspectable
    var leftTextInset: CGFloat {
        set { textInsets.left = newValue }
        get { return textInsets.left }
    }
    
    @IBInspectable
    var rightTextInset: CGFloat {
        set { textInsets.right = newValue }
        get { return textInsets.right }
    }
    
    @IBInspectable
    var topTextInset: CGFloat {
        set { textInsets.top = newValue }
        get { return textInsets.top }
    }
    
    @IBInspectable
    var bottomTextInset: CGFloat {
        set { textInsets.bottom = newValue }
        get { return textInsets.bottom }
    }
}
