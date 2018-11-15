//
//  Constants.swift
//  Flickr
//
//  Created by Pankaj Verma on 07/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import Foundation

struct K {
        static let baseUrl = "https://api.flickr.com/services/rest/?"
        static let entitiName = "FlickrPhotos"
        static let defaultImageName = "poster"
    
    }


struct ApiKey {
    static let method = "method"
    static let api_key="api_key"
    static let format="format"
    static let nojsoncallback="nojsoncallback"
    static let safe_search="safe_search"
    static let text="text"
}

struct DefaultApiKeyValue {
    static let method = "flickr.photos.search"
    static let api_key="3e7cc266ae2b0e0d78e279ce8e361736"
    static let format="json"
    static let nojsoncallback="1"
    static let safe_search="1"
    static let text="Pankaj"
}

struct PersistenceKey {
    static let data = "data"
    static let url = "url"
}

//struct ApiThreshold {
//    static let 
//}
