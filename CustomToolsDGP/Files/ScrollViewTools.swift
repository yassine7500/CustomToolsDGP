//
//  ScrollViewTools.swift
//  CustomToolsDGP
//
//  Created by David SG on 23/07/2020.
//  Copyright © 2020 David Galán. All rights reserved.
//

extension UIScrollView {

    public func scrollTo(horizontalPage: Int? = 0, verticalPage: Int? = 0, animated: Bool? = true) {
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? 0)
        frame.origin.y = frame.size.width * CGFloat(verticalPage ?? 0)
        self.scrollRectToVisible(frame, animated: animated ?? true)
    }

}
