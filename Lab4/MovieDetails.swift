//
//  MovieDetails.swift
//  Lab4
//
//  Created by Camilla Moraes on 10/7/17.
//  Copyright © 2017 Camilla Moraes. All rights reserved.
//

import UIKit

class MovieDetails: UIViewController {
    
    var movieInfo: Movie!
    
    @IBOutlet weak var voteField: UILabel!
    @IBOutlet weak var originalLangField: UILabel!
    @IBOutlet weak var releasedField: UILabel!
    @IBOutlet weak var favoritesBar: UITabBarItem!
    @IBOutlet weak var movieBar: UITabBarItem!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var navTop: UINavigationBar!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = movieInfo.name
        
        //set average vote field
        self.voteField.text = "\(self.movieInfo.rating)"

        //set release date field
        if(self.movieInfo.releaseDate == "") {
            self.releasedField.text = "N/A"
        }
        else {
            self.releasedField.text = "\(self.movieInfo.releaseDate)"
        }

        //set language field
        if(self.movieInfo.originalLang == "en") {
            self.originalLangField.text = "English"
        }
        else if(self.movieInfo.originalLang == "fr") {
            self.originalLangField.text = "French"
        }
        else if(self.movieInfo.originalLang == "ja") {
            self.originalLangField.text = "Japanese"
        }
        else if(self.movieInfo.originalLang == "de") {
            self.originalLangField.text = "German"
        }
        else if(self.movieInfo.originalLang == "pt") {
            self.originalLangField.text = "Portuguese"
        }
        else if(self.movieInfo.originalLang == "es") {
            self.originalLangField.text = "Spanish"
        }
        else if(self.movieInfo.originalLang == "he") {
            self.originalLangField.text = "Hebrew"
        }
        else if(self.movieInfo.originalLang == "ar") {
            self.originalLangField.text = "Arabic"
        }
        else if(self.movieInfo.originalLang == "ko") {
            self.originalLangField.text = "Korean"
        }
        else if(self.movieInfo.originalLang == "zh") {
            self.originalLangField.text = "Mandarin"
        }
        else if(self.movieInfo.originalLang == "cn") {
            self.originalLangField.text = "Cantonese"
        }
        else {
            self.originalLangField.text = "\(self.movieInfo.originalLang)"
        }
        
        //got some of the following lines of code from https://stackoverflow.com/questions/37018916/swift-async-load-image
        let url = URL(string: movieInfo.url)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                if data == nil {
                    self.movieImage.image = #imageLiteral(resourceName: "Null")
                }
                else {
                    self.movieImage.image = UIImage(data: data!)

                }
            }
        }
    
        self.navItem.title = movieInfo.name
        
        self.navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
    }
    
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getJSON(path: String) -> JSON
    {
        guard let url = URL(string: path) else { return JSON.null }
        do {
            let data = try Data(contentsOf: url)
            return try JSON(data: data)
        } catch {
            return JSON.null
        }
    }
    

    @IBAction func favoritesButton(_ sender: Any) {
        var favorites = UserDefaults.standard.array(forKey: "favorites") as? [String]
        //if favorites is empty
        if favorites == nil
        {
            favorites = []
        }
        //if favorites already contains movie
        if (favorites?.contains(movieInfo.name))!
        {
            let ac = UIAlertController(title: "Oops!", message: "This movie has already been added to your favorites." , preferredStyle: .alert)
            ac.addAction(UIAlertAction(title:"OK", style: .default, handler:nil))
            present(ac, animated:true, completion:nil)
        }
        //if favorites doesn't contain movie - append to dictionary, set key
        else
        {
            favorites?.append(movieInfo.name)
            UserDefaults.standard.set(favorites, forKey: "favorites")
            let ac = UIAlertController(title: "Success!", message: "This movie has been added to your favorites." , preferredStyle: .alert)
            ac.addAction(UIAlertAction(title:"OK", style: .default, handler:nil))
            present(ac, animated:true, completion:nil)
        }
    }
    
    @IBAction func descriptionButton(_ sender: Any) {
        performSegue(withIdentifier: "description", sender: AnyIndex.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "description"
        {
            let destination = segue.destination as? Description
            destination!.movieDescription = movieInfo
        }
    }
}
