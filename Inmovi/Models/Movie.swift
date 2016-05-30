//
//  Movie.swift
//  Inmovi
//
//  Created by Alfonse MBP 00 on 5/30/16.
//  Copyright © 2016 Alvonse. All rights reserved.
//

import Foundation
import RealmSwift

class Movie: Object {
    dynamic var id: String? = nil
    dynamic var title: String? = nil
    dynamic var summary: String? = nil
    dynamic var siteURL: String? = nil
    dynamic var imageURL: String? = nil
    dynamic var createdDate: String? = nil
    dynamic var updatedDate: String? = nil
    let duration = RealmOptional<Int>()
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
