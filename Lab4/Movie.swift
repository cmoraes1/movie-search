//
//  Movie.swift
//  Lab4
//
//  Created by Camilla Moraes on 10/7/17.
//  Copyright © 2017 Camilla Moraes. All rights reserved.
//

import Foundation
import UIKit

struct Movie {
    var name: String
    var url: String
    var originalLang: String
    var releaseDate: String
    var rating: Double
    var id: Int
    var description: String

    
    init(name: String, url: String, originalLang: String, releaseDate: String, rating: Double, id: Int, description: String) {
        self.name = name
        self.url = url
        self.originalLang = originalLang
        self.releaseDate = releaseDate
        self.rating = rating
        self.id = id
        self.description = description
    }

}
