//
//  RequestManager.swift
//  Flickr
//
//  Created by Pankaj Verma on 07/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import Foundation

struct FlickrUrlManager {
    static let defaultSearchUrl = ApiUrlGenerator.DefaultSearch.url
    static func getSearchUrlForText(text:String)->String{
        return ApiUrlGenerator.Search(text: text).url
    }
    static func getImageUrlFor(farm:String?, server:String?, id:String?, secret:String?)->String?{
        guard let farm = farm else{
            return nil
        }
        guard let server = server else {
            return nil
        }
        guard let id = id else {
            return nil
        }
        guard let secret = secret else {
            return nil
        }
        return ImageUrlGenerator.ImageUrl(farm, server, id, secret).url
    }

    
    
    private enum ApiUrlGenerator {
        case Search(text:String)
        case DefaultSearch
        
        var url: String {
            let builder:String = """
            \(K.baseUrl)\
            &\(ApiKey.method)=\(DefaultApiKeyValue.method)\
            &\(ApiKey.api_key)=\(DefaultApiKeyValue.api_key)\
            &\(ApiKey.format)=\(DefaultApiKeyValue.format)\
            &\(ApiKey.nojsoncallback)=\(DefaultApiKeyValue.nojsoncallback)\
            &\(ApiKey.safe_search)=\(DefaultApiKeyValue.safe_search)
            """
            
            switch self {
            case .Search(let searchText):
                return "\(builder)&\(ApiKey.text)=\(searchText)"
            case .DefaultSearch:
                return "\(builder)&\(ApiKey.text)=\(DefaultApiKeyValue.text)"
            }
        }
    }
    
    private enum ImageUrlGenerator {
        case ImageUrl(String,String,String,String)
        
        var url:String{
            switch self {
            case .ImageUrl(let farm, let server, let id, let secret):
                return "http://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
            }
        }
        
    }
    
   }

