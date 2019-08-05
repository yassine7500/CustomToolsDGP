//
//  LinearGlossGradientViewSample.swift
//  CustomToolsDGP
//
//  Created by David Galán on 23/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

//
//import UIKit
//import Foundation
//
//class LinearGlossGradientView: UIView {
//    //    var lightColor = UIColor(red: 105/255.0, green: 179/255.0, blue: 216/255.0, alpha: 1)
//    //    var darkColor = UIColor(red: 21/255.0, green: 92/255.0, blue: 136/255.0, alpha: 1)
//
//    var lightColor = #colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1)
//    var darkColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
//
//    @IBInspectable var coloredBoxHeight: CGFloat = 80
//
//    class func loadViewFromNib() -> LinearGlossGradientView? {
//        let bundle = Bundle.main
//        let nib = UINib(nibName: "LinearGlossGradientView", bundle: bundle)
//        guard
//            let view = nib.instantiate(withOwner: LinearGlossGradientView())
//                .first as? LinearGlossGradientView
//            else {
//                return nil
//        }
//
//        return view
//    }
//
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//        var coloredBoxRect = bounds
//        coloredBoxRect.size.height = coloredBoxHeight
//
//        var paperRect = bounds
//        paperRect.origin.y += coloredBoxHeight
//        paperRect.size.height = bounds.height - coloredBoxHeight
//
//        let context = UIGraphicsGetCurrentContext()!
//
//        //    context.setFillColor(UIColor.red.cgColor)
//        //    context.fill(coloredBoxRect)
//        //
//        //    context.setFillColor(UIColor.green.cgColor)
//        //    context.fill(paperRect)
//
//        let shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
//
//        context.saveGState()
//        context.setShadow(offset: CGSize(width: 0, height: 2), blur: 3.0, color: shadowColor.cgColor)
//        context.setFillColor(lightColor.cgColor)
//        context.fill(coloredBoxRect)
//        context.restoreGState()
//
//        context.drawGlossAndGradient(rect: coloredBoxRect, startColor: lightColor, endColor: darkColor)
//        context.setStrokeColor(darkColor.cgColor)
//        context.setLineWidth(1)
//        context.stroke(coloredBoxRect.rectFor1PxStroke())
//    }
//}
//
//
//
//
//extension CGContext {
//    func drawLinearGradient(rect: CGRect, startColor: UIColor, endColor: UIColor) {
//        let gradient = CGGradient(colorsSpace: nil, colors: [startColor.cgColor, endColor.cgColor] as CFArray, locations: [0, 1])!
//
//        let startPoint = CGPoint(x: rect.midX, y: rect.minY)
//        let endPoint = CGPoint(x: rect.midX, y: rect.maxY)
//
//        saveGState()
//        addRect(rect)
//        clip()
//        drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
//
//        restoreGState()
//    }
//
//    func draw1PxStroke(startPoint: CGPoint, endPoint: CGPoint, color: UIColor) {
//        saveGState()
//        setLineCap(.square)
//        setStrokeColor(color.cgColor)
//        setLineWidth(1)
//        move(to: startPoint+0.5)
//        addLine(to: endPoint)
//        strokePath()
//        restoreGState()
//    }
//
//    func drawGlossAndGradient(rect: CGRect, startColor: UIColor, endColor: UIColor) {
//        drawLinearGradient(rect: rect, startColor: startColor, endColor: endColor)
//
//        let glossColor1 = UIColor.white.withAlphaComponent(0.35)
//        let glossColor2 = UIColor.white.withAlphaComponent(0.1)
//
//        var topHalf = rect
//        topHalf.size.height /= 2
//
//        drawLinearGradient(rect: topHalf, startColor: glossColor1, endColor: glossColor2)
//    }
//}
//
//extension CGRect {
//    func rectFor1PxStroke() -> CGRect {
//        return CGRect(x: origin.x + 0.5, y: origin.y + 0.5, width: size.width - 1, height: size.height - 1)
//    }
//}
//
//
//extension CGPoint {
//    static func +(left: CGPoint, right: CGFloat) -> CGPoint {
//        return CGPoint(x: left.x + right, y: left.y + right)
//    }
//}
//
