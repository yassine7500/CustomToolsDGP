//
//  CellTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 23/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public class CellTools {
    
    public init() {
        
    }
    
    public func changeBackgroundColorBetweenCells(view: UIView, indexPath: IndexPath, cellColorOne: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cellColorTwo: UIColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)) {
        
        if indexPath.row%2 == 0 {
            view.backgroundColor = cellColorOne
        } else {
            view.backgroundColor = cellColorTwo
        }
    }
    
}
