//
//  DetailsViewController.swift
//  Flickr
//
//  Created by Pankaj Verma on 07/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var imageUrlLabel:UILabel!

    var url:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let imgData = getImageDataForPhoto(photo){
//            let image = UIImage(data: imgData)
//            self.posterImageView.image = image
//            
//        }else{
//            posterImageView.image = UIImage(named: K.defaultImageName)
//        }
 
//        farmLabel.text = "\(photo?.farm  ?? 0)"
//        idLabel.text = photo?.id
//        secretLabel.text = photo?.secret
        self.imageUrlLabel.text = url
    }
   
//    func getImageDataForPhoto(_ photo:Photo?) -> Data? {
//        guard let photo = photo else{
//            return nil
//        }
//        guard let farm = photo.farm else{
//            return nil
//        }
//        guard let server = photo.server else {
//            return nil
//        }
//        guard let id = photo.id else {
//            return nil
//        }
//        guard let secret = photo.secret else {
//            return nil
//        }
//        let flickrImageUrl="http://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
//        imageUrlLabel.text = flickrImageUrl
//        return imageCache.getImageForKey(flickrImageUrl)
//    }
}
