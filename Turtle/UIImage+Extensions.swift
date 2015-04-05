//
//  UIImage+Extensions.swift
//  Turtle
//
//  Created by Pedro Ruíz on 4/2/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

import Foundation

extension UIImage
{
    func resize(targetWidth: CGFloat) -> UIImage
    {
        var originalWidth = self.size.width
        
        if originalWidth <= targetWidth
        {
            return self
        }
        
        var scaleFactor = targetWidth / originalWidth
        var targetHeight = self.size.height * scaleFactor
        
        var targetSize = CGSizeMake(targetWidth, targetHeight)
        
        UIGraphicsBeginImageContext(targetSize)
        
        self.drawInRect(CGRectMake(0, 0, targetWidth, targetHeight))
        
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}