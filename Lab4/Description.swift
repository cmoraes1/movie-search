//
//  Description.swift
//  Lab4
//
//  Created by Camilla Moraes on 10/21/17.
//  Copyright © 2017 Camilla Moraes. All rights reserved.
//

import UIKit

class Description: UIViewController  {
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    var movieDescription: Movie!

    @IBOutlet weak var navBar: UINavigationBar!

    @IBOutlet weak var descriptionField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.movieDescription.description == "") {
            self.descriptionField.text = "There is no description for this movie"
        }
        else {
            self.descriptionField.text = "\(self.movieDescription.description)"
        }
        
        self.navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
    }
    
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

