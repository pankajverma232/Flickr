//
//  ImageCell.swift
//  Flickr
//
//  Created by Pankaj Verma on 06/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var imageDownloadTask:URLSessionDataTask?
    lazy var imageCache:ImageCache = ImageCache()
    let userQueueName = "flicker"
    public func configure(with photo: Photo) {
        
        let url = FlickrUrlManager.getImageUrlFor(farm: "\(photo.farm ?? 0)", server: photo.server, id: photo.id, secret: photo.secret)
        loadImage(forUrl: url)
    }

    
    func loadImage(forUrl imageUrl:String?) -> Void {
        imageView.image = UIImage(named: K.defaultImageName)
        guard let imageUrl = imageUrl else{
            return
        }
        if let imgData = imageCache.getImageForKey(imageUrl){
            //fetched from coredata
            let image = UIImage(data: imgData)
            self.imageView.image = image
            return
        }
            //load from server
            guard let photoUrl = URL(string: imageUrl) else {
                return
            }
            imageDownloadTask = URLSession.shared.dataTask(with: photoUrl) { (data, response
                , error) in
                guard let data = data else {
                    return
                }
                
                DispatchQueue.main.async { [unowned self] in
                    if(imageUrl == response?.url?.absoluteString){
                    self.imageView.image = UIImage(data: data)
                    }
                    self.imageCache.addImage(data: data, forKey: imageUrl)
                }
            }
            imageDownloadTask?.resume()
        }
}
