//
//  Ex+UIImage.swift
//  GukbapMinister
//
//  Created by Martin on 2023/02/02.
//

import Foundation
import UIKit


extension UIImage {
    
    func resizeImageTo(size: CGSize) -> UIImage {
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            self.draw(in: CGRect(origin: CGPoint.zero, size: size))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return resizedImage
    }
}
