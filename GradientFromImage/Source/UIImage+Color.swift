//
//  UIImage+Color.swift
//  GradientFromImage
//
//  Created by Shawn Roller on 7/23/18.
//  Copyright © 2018 Shawn Roller. All rights reserved.
//
        
import UIKit

extension UIImage {
            
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        guard let cgImage = cgImage, let pixelData = cgImage.dataProvider?.data else { return UIColor.clear }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let bytesPerPixel = cgImage.bitsPerPixel / 8
        let y = pos.y > 0 ? pos.y - 1 : 0
        let x = pos.x > 0 ? pos.x - 1 : 0
        let pixelInfo = ((Int(self.size.width) * Int(y)) + Int(x)) * bytesPerPixel
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    func getGradient(frame: CGSize) -> CAGradientLayer {
        let (firstColor, lastColor) = getGradientColors()
        
        let gradient = CAGradientLayer()
        gradient.colors = [firstColor.cgColor, lastColor.cgColor]
        
        return gradient
    }
    
    func getGradientColors() -> (firstColor: UIColor, lastColor: UIColor) {
        let firstPoint = CGPoint.zero
        let lastPoint = CGPoint(x: self.size.width, y: self.size.height)
        let firstColor = getPixelColor(pos: firstPoint)
        let lastColor = getPixelColor(pos: lastPoint)
        
        return (firstColor, lastColor)
    }
    
}
