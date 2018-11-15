//
//  Persistable.swift
//  Flickr
//
//  Created by Pankaj Verma on 15/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import Foundation
protocol Persistable {
    func saveUrls(_ urls:[String])
    func removeUrs()
}
