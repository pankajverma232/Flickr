//
//  Photo.swift
//  Flickr
//
//  Created by Pankaj Verma on 06/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import Foundation

struct Root : Decodable {
    
    private enum CodingKeys : String, CodingKey {
        case stat
        case subPhotos = "photos"
    }
    
    let stat : String?
    let subPhotos : SubPhotos?
}

struct SubPhotos:Decodable {
    private enum CodingKeys : String, CodingKey {
   
        case page
        case pages
        case perpage
        case total
        case photos = "photo"
    }
    
    let page : Int?
    let pages : Int?
    let perpage : Int?
    let total: String?
    let photos : [Photo]?
}

struct Photo:Decodable {
    let title: String?
    let server:String?
    let secret:String?
    let id:String?
    let owner:String?
    let farm:Int?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case server
        case secret
        case id
        case owner
        case farm
    }
 
}


