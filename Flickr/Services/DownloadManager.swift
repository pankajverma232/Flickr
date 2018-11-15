//
//  DownloadManager.swift
//  Flickr
//
//  Created by Pankaj Verma on 10/11/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import Foundation
class DownloadManager {
    var photoDownloadTask:URLSessionDataTask?
    var imageDownloadTask:URLSessionDataTask?

    var flickrUrlString = FlickrUrlManager.defaultSearchUrl
    lazy var imageCache:PersistanceManager = PersistanceManager()
    var searchText:String = ""{
        willSet(newText) {
        flickrUrlString = FlickrUrlManager.getSearchUrlForText(text: newText)
        imageCache.removeUrs()
        loadPosters()
        }
    }
    
    
 
    func loadPosters() -> Void {
       // startIndex = 0
        guard let flickrUrl = URL(string: flickrUrlString) else { return }
        //cancell active task(if any) first since it's of no use now
        photoDownloadTask?.cancel()
        photoDownloadTask = URLSession.shared.dataTask(with: flickrUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                
                let root = try decoder.decode(Root.self, from: data)
                DispatchQueue.main.async { [unowned self] in
                    if let receivedphotos = root.subPhotos?.photos{
                        var urls:[String] = [String]()
                        for receivedphoto in receivedphotos{
                            let url = FlickrUrlManager.getImageUrlFor(farm: "\(receivedphoto.farm ?? 0)", server: receivedphoto.server, id: receivedphoto.id, secret: receivedphoto.secret)
                            urls.append(url!)
                        }
                         self.imageCache.saveUrls(urls)
                        urls = [String]()
                    }
                }
            } catch let err {
                print("Err", err)
            }
        }
        photoDownloadTask?.resume()
    }
    
    func downloadImage(forUrl imageUrl:String?, completion: @escaping (Data?) -> Void) -> Void {
        
        guard let imageUrl = imageUrl else{
            completion(nil)
            return
        }
        //load from server
        imageDownloadTask?.cancel()
        guard let photoUrl = URL(string: imageUrl) else {
            completion(nil)
            return
        }
        imageDownloadTask = URLSession.shared.dataTask(with: photoUrl) { (data, response
            , error) in
            guard let data = data else {
                return
            }
            
            
            if(imageUrl == response?.url?.absoluteString){
                DispatchQueue.main.async {
                    completion(data)
                    return
                }
                completion(nil)
            }
        }
        imageDownloadTask?.resume()
    }
    
}
