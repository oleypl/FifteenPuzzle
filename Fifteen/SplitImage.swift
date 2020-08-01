//
//  SplitImage.swift
//  Fifteen
//
//  Created by Michal Olejniczak on 01/08/2020.
//  Copyright © 2020 Michal Olejniczak. All rights reserved.
//

import Foundation
import UIKit

class SplitImage{

    var images4: [UIImage?] = []
    var images16: [UIImage?] = []


    func makeSplit(image: UIImage){

        let topHalf = image.topHalf
        let bottomHalf = image.bottomHalf

        let firstLine = topHalf?.topHalf
        let secondLine = topHalf?.bottomHalf
        let thirdLine = bottomHalf?.topHalf
        let fourthLine = bottomHalf?.bottomHalf
        
        self.images4.append(firstLine)
        self.images4.append(secondLine)
        self.images4.append(thirdLine)
        self.images4.append(fourthLine)
        
        self.images4.forEach{image in
            let leftPart1 = image?.leftHalf
            let rightPart1 = image?.rightHalf
            let leftPart2 = leftPart1?.leftHalf
            let leftPart3 = leftPart1?.rightHalf
            let rightPart2 = rightPart1?.rightHalf
            let rightPart3 = rightPart1?.leftHalf

            self.images16.append(leftPart2)
            self.images16.append(leftPart3)
            self.images16.append(rightPart3)
            self.images16.append(rightPart2)
        }
}
    
    func getImages4() -> [UIImage?]{
        return images4
    }
    

    func getImages16() -> [UIImage?]{
        return images16
    }
    
}

extension UIImage {
    var topHalf: UIImage? {
        guard let image = cgImage?
            .cropping(to: CGRect(origin: .zero,
                    size: CGSize(width: size.width,
                                 height: size.height / 2 )))
        else { return nil }
        return UIImage(cgImage: image, scale: 1, orientation: imageOrientation)
    }
    var bottomHalf: UIImage? {
        guard let image = cgImage?
            .cropping(to: CGRect(origin: CGPoint(x: 0,
                                                 y: size.height - (size.height/2).rounded()),
                                 size: CGSize(width: size.width,
                                              height: size.height -
                                                      (size.height/2).rounded())))
        else { return nil }
        return UIImage(cgImage: image)
    }
    var leftHalf: UIImage? {
        guard let image = cgImage?
            .cropping(to: CGRect(origin: .zero,
                                 size: CGSize(width: size.width/2,
                                              height: size.height)))
        else { return nil }
        return UIImage(cgImage: image)
    }
    var rightHalf: UIImage? {
        guard let image = cgImage?
            .cropping(to: CGRect(origin: CGPoint(x: size.width - (size.width/2).rounded(), y: 0),
                                 size: CGSize(width: size.width - (size.width/2).rounded(),
                                              height: size.height)))
        else { return nil }
        return UIImage(cgImage: image)
    }
    
}
