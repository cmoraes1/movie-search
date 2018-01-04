//
//  Cell.swift
//  Lab4
//
//  Created by Camilla Moraes on 10/11/17.
//  Copyright © 2017 Camilla Moraes. All rights reserved.
//

import Foundation
import UIKit

class Cell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    var image: UIImage! {
        didSet {
            movieImage.image = image
        }
    }
    
}
