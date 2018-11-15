//
//  AsyncImageView.swift
//  Flickr
//
//  Created by Pankaj Verma on 14/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import UIKit

class AsyncImageView: UIView {
    private var _image:UIImage?
    var image:UIImage?{
        get{
            return _image
        }
        set{
            _image = newValue
            layer.contents = nil
            guard let image = newValue else {
                return
            }
            DispatchQueue.global(qos: .userInitiated).async {
                let decodedImage = self.decodeImage(image)
                DispatchQueue.main.async {
                    self.layer.contents = decodedImage?.cgImage
                }
            }
        }
    }
    
    func decodeImage(_ image:UIImage)->UIImage?{
        guard let newImage = image.cgImage else{return nil}
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: newImage.width, height: newImage.height, bitsPerComponent: 8, bytesPerRow: newImage.width*4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        context?.draw(newImage, in: CGRect(x: 0, y: 0, width: newImage.width, height: newImage.height))
        let decodedImage = context?.makeImage()
        if let decodedImage = decodedImage{
            return UIImage(cgImage: decodedImage)
        }
        return nil
    }

}
