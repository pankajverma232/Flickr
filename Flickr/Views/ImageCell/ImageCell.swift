//
//  ImageCell.swift
//  Flickr
//
//  Created by Pankaj Verma on 06/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: AsyncImageView!
    @IBOutlet weak var activityIndicatorView:UIActivityIndicatorView!
    
    var image:UIImage?{
        didSet{
            imageView.image = image
        }
    }
    let downloadManager = DownloadManager()
    func setImageForUrl(url:String) {
         activityIndicatorView.startAnimating()
        image = UIImage(named: K.defaultImageName)
        downloadManager.downloadImage(forUrl: url) { (data) in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                if let data = data{
                    self.image = UIImage(data: data)
                }
            }
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadManager.imageDownloadTask?.cancel()
    }
    
}
