//
//  SwiftNotice.swift
//  SwiftNotice
//
//  Created by JohnLui on 15/4/15.
//  Copyright (c) 2015年 com.lvwenhan. All rights reserved.
//

import Foundation
import UIKit

var pleaseWaitActive = false

extension UIViewController {
    
    public func notice(_ text: String, type: NoticeType, autoClear: Bool = true) {
        SwfitNoticeTools.showNoticeWithText(type, text: text, autoClear: autoClear)
    }
    
    public func pleaseWait() {
        if !pleaseWaitActive {
            pleaseWaitActive = true
            self.view.isUserInteractionEnabled = false
            SwfitNoticeTools.wait()
        }
    }
    
    public func pleaseWait(_ text: String) {
        SwfitNoticeTools.wait(text)
    }
    
    public func noticeOnlyText(_ text: String) {
        SwfitNoticeTools.showText(text)
    }
    
    public func clearAllNotice() {        
        DispatchQueue.main.async {
            pleaseWaitActive = false
            self.view.isUserInteractionEnabled = true
            SwfitNoticeTools.clear()
        }
    }
    
}

public enum NoticeType {
    case success
    case error
    case info
}

class SwfitNoticeTools: NSObject {
    
    static var mainViews = Array<UIView>()
    static let rv: UIView = UIApplication.shared.keyWindow!
    
    static func clear() {
        for i in mainViews {
            i.removeFromSuperview()
        }
    }
    
    static func wait() {
        
        let darkBackground = UIView(frame: CGRect(x: 0, y: 0, width: rv.frame.width, height: rv.frame.height))
        darkBackground.center = rv.center
        darkBackground.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        rv.addSubview(darkBackground)
        
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 78, height: 78))
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.8)
        
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        ai.frame = CGRect(x: 21, y: 21, width: 36, height: 36)
        ai.startAnimating()
        mainView.addSubview(ai)
        
        mainView.center = rv.center
        mainViews.append(mainView)
        mainViews.append(darkBackground)
        
        rv.addSubview(mainView)
        rv.bringSubviewToFront(mainView)
    }
    
    static func wait(_ text: String) {
        
        let darkBackground = UIView(frame: CGRect(x: 0, y: 0, width: rv.frame.width, height: rv.frame.height))
        darkBackground.center = rv.center
        darkBackground.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        rv.addSubview(darkBackground)
        
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        let frame = CGRect(x: 0, y: 60, width: 90, height: 16)
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.8)
        
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        ai.frame = CGRect(x: 27, y: 15, width: 36, height: 36)
        ai.startAnimating()
        mainView.addSubview(ai)
        
        
        let label = UILabel(frame: frame)
        label.text = text
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        mainView.addSubview(label)
        
        mainView.center = rv.center
        mainViews.append(mainView)
        mainViews.append(darkBackground)
        
        rv.addSubview(mainView)
        rv.bringSubviewToFront(mainView)
    }
    
    static func showText(_ text: String) {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 60)
        let mainView = UIView(frame: frame)
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.8)
        
        let label = UILabel(frame: frame)
        label.text = text
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        mainView.addSubview(label)
        
        mainView.center = rv.center
        mainViews.append(mainView)
        
        rv.addSubview(mainView)
        rv.bringSubviewToFront(mainView)
    }
    
    static func showNoticeWithText(_ type: NoticeType,text: String, autoClear: Bool) {
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        mainView.layer.cornerRadius = 10
        mainView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.7)
        
        var image = UIImage()
        switch type {
        case .success:
            image = SwiftNoticeSDK.imageOfCheckmark
        case .error:
            image = SwiftNoticeSDK.imageOfCross
        case .info:
            image = SwiftNoticeSDK.imageOfInfo
            
        }
        let checkmarkView = UIImageView(image: image)
        checkmarkView.frame = CGRect(x: 27, y: 15, width: 36, height: 36)
        mainView.addSubview(checkmarkView)
        
        let label = UILabel(frame: CGRect(x: 0, y: 60, width: 90, height: 16))
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        label.text = text
        label.textAlignment = NSTextAlignment.center
        mainView.addSubview(label)
        
        mainView.center = rv.center
        mainViews.append(mainView)
        
        rv.addSubview(mainView)
        rv.bringSubviewToFront(mainView)
        
        if autoClear {
            let selector = #selector(SwfitNoticeTools.hideNotice(_:))
            self.perform(selector, with: mainView, afterDelay: 3)
        }
    }
    
    @objc static func hideNotice(_ sender: AnyObject) {
        if sender is UIView {
            sender.removeFromSuperview()
        }
    }
}

class SwiftNoticeSDK {
    struct Cache {
        static var imageOfCheckmark: UIImage?
        static var imageOfCross: UIImage?
        static var imageOfInfo: UIImage?
    }
    class func draw(_ type: NoticeType) {
        let checkmarkShapePath = UIBezierPath()
        
        // draw circle
        checkmarkShapePath.move(to: CGPoint(x: 36, y: 18))
        checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 18), radius: 17.5, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        checkmarkShapePath.close()
        
        switch type {
        case .success: // draw checkmark
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.addLine(to: CGPoint(x: 16, y: 24))
            checkmarkShapePath.addLine(to: CGPoint(x: 27, y: 13))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.close()
        case .error: // draw X
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 10))
            checkmarkShapePath.addLine(to: CGPoint(x: 26, y: 26))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 26))
            checkmarkShapePath.addLine(to: CGPoint(x: 26, y: 10))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 10))
            checkmarkShapePath.close()
        case .info:
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 6))
            checkmarkShapePath.addLine(to: CGPoint(x: 18, y: 22))
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 6))
            checkmarkShapePath.close()
            
            UIColor.white.setStroke()
            checkmarkShapePath.stroke()
            
            let checkmarkShapePath = UIBezierPath()
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 27))
            checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 27), radius: 1, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
            checkmarkShapePath.close()
            
            UIColor.white.setFill()
            checkmarkShapePath.fill()
        }
        
        UIColor.white.setStroke()
        checkmarkShapePath.stroke()
    }
    class var imageOfCheckmark: UIImage {
        if (Cache.imageOfCheckmark != nil) {
            return Cache.imageOfCheckmark!
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
        
        SwiftNoticeSDK.draw(NoticeType.success)
        
        Cache.imageOfCheckmark = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.imageOfCheckmark!
    }
    class var imageOfCross: UIImage {
        if (Cache.imageOfCross != nil) {
            return Cache.imageOfCross!
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
        
        SwiftNoticeSDK.draw(NoticeType.error)
        
        Cache.imageOfCross = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.imageOfCross!
    }
    class var imageOfInfo: UIImage {
        if (Cache.imageOfInfo != nil) {
            return Cache.imageOfInfo!
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
        
        SwiftNoticeSDK.draw(NoticeType.info)
        
        Cache.imageOfInfo = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.imageOfInfo!
    }
}
// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net
