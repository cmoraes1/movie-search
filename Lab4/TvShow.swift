//
//  TvShow.swift
//  Lab4
//
//  Created by Camilla Moraes on 10/23/17.
//  Copyright © 2017 Camilla Moraes. All rights reserved.
//

import UIKit

struct TvShow {
    var name: String
    var url: String
    var originalLang: String
    
    init(name: String, url: String, originalLang: String) {
        self.name = name
        self.url = url
        self.originalLang = originalLang
    }
    
}
