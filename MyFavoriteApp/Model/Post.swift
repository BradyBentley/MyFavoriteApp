//
//  Post.swift
//  MyFavoriteApp
//
//  Created by Brady Bentley on 12/12/18.
//  Copyright © 2018 Brady. All rights reserved.
//

import Foundation

struct Post: Codable {
    let favApp: String
    let name: String
    
    init(favApp: String, name: String) {
        self.favApp = favApp
        self.name = name
    }
    
}

