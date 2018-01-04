//
//  ViewController.swift
//  Lab4
//
//  Created by Camilla Moraes on 10/7/17.
//  Copyright © 2017 Camilla Moraes. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, WKNavigationDelegate {
   
    var webView: WKWebView!
    var movies = [Movie]()
    var theImageCache: [UIImage] = []
    var textLabel: UILabel!
    var imageView: UIImageView!
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var navBarItem: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        webView = WKWebView()
        webView.navigationDelegate = self
        spinner.isHidden = true
        fetchHomePageData()
        searchBar.delegate = self
        setupCollectionView()
        cacheImages()
        
        self.navBarItem.rightBarButtonItem = UIBarButtonItem(title: "See Webpage", style: .plain, target: self, action: #selector(openTapped))
        
        let UserDefault = UserDefaults.standard
        var favs = UserDefault.array(forKey: "favorites") as? [String]
        
        if favs == nil
        {
            favs = []
        }
    }
    
    func openPage(action: UIAlertAction!) {
        _ = URL(string: "https://" + action.title!)!
        
        showWebPage((Any).self)
    }
    
    func showWebPage(_ sender: Any) {
        performSegue(withIdentifier: "webpage", sender: AnyIndex.self)
    }
    
    
    func openTapped() {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "themoviedb.org", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //set up number of sections in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int) -> Int {
        return movies.count
    }
    
    //set up collection view
    func setupCollectionView() {
        movieCollectionView.dataSource = self as UICollectionViewDataSource
        movieCollectionView.delegate = self as UICollectionViewDelegate
    }
    

    //load data into collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieIcon", for: indexPath) as! Cell
        
        cell.textLabel.text! = movies[indexPath.row].name
        cell.movieImage.image = theImageCache[indexPath.row]
        
        return cell
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let searchText = searchBar.text?.replacingOccurrences(of: " ", with: "+")
        
        self.spinner.startAnimating()
        self.spinner.isHidden = false
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.fetchDataCollectionView(name: searchText!)
            self.cacheImages()
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
            }
        }
    }
    
    //fetch data
    func fetchDataCollectionView(name: String) {
        movies.removeAll()
        theImageCache.removeAll()
        movieCollectionView.reloadData()
        
        let json = getJSON(path: "https://api.themoviedb.org/3/search/movie?api_key=fa3a5e52cbd9e145957d09e0ab944679&query=\(name)&page=1")
        let imageURL = "https://image.tmdb.org/t/p/w500/"
        
            for result in json["results"].arrayValue {
                let name = result["original_title"].stringValue
                let originalLang = result["original_language"].stringValue
                let rating = result["vote_average"].doubleValue
                let releaseDate = result["release_date"].stringValue
                let id = result["id"].intValue
                let description = result["description"].stringValue
                
                //if poster path doesn't exist
                if(result["poster_path"].stringValue == "")
                {
                    let url = "Null.png"
                    movies.append(Movie(name: name, url: url, originalLang: originalLang, releaseDate: releaseDate, rating: rating, id: id, description: description))
                }
                else
                {
                    let url = imageURL + result["poster_path"].stringValue
                    movies.append(Movie(name: name, url: url, originalLang: originalLang, releaseDate: releaseDate, rating: rating, id: id, description: description))
                }
        }
        
    }
    
    
    //fetch data to appear when app opens
    func fetchHomePageData() {
        let json = getJSON(path: "https://api.themoviedb.org/3/search/movie?api_key=fa3a5e52cbd9e145957d09e0ab944679&query=A&page=1")
        
        let imageURL = "https://image.tmdb.org/t/p/w500/"

        for result in json["results"].arrayValue {
            let name = result["original_title"].stringValue
            let originalLang = result["original_language"].stringValue
            let rating = result["vote_average"].doubleValue
            let releaseDate = result["release_date"].stringValue
            let id = result["id"].intValue
            let description = result["overview"].stringValue
            
            //if poster path doesn't exist
            if(result["poster_path"].stringValue == "")
            {
                let url = "Null.png"
                movies.append(Movie(name: name, url: url, originalLang: originalLang, releaseDate: releaseDate, rating: rating, id: id, description: description))
            }
            else
            {
                let url = imageURL + result["poster_path"].stringValue
                movies.append(Movie(name: name, url: url, originalLang: originalLang, releaseDate: releaseDate, rating: rating, id: id, description: description))
            }
        }
    }
    
    //fetch tv show data
    func TvShow(name: String) {
        movies.removeAll()
        theImageCache.removeAll()
        movieCollectionView.reloadData()
        
        let json = getJSON(path: "https://api.themoviedb.org/3/search/tv?api_key=fa3a5e52cbd9e145957d09e0ab944679&query=\(name)&page=1")
        let imageURL = "https://image.tmdb.org/t/p/w500/"
        
        for result in json["results"].arrayValue {
                let name = result["original_name"].stringValue
                let originalLang = result["original_language"].stringValue
                let rating = result["vote_average"].doubleValue
                let releaseDate = result["release_date"].stringValue
                let id = result["id"].intValue
                let description = result["overview"].stringValue
            
                //if poster path doesn't exist
                if(result["poster_path"].stringValue == "")
                {
                    let url = "Null.png"
                    movies.append(Movie(name: name, url: url, originalLang: originalLang, releaseDate: releaseDate, rating: rating, id: id, description: description))
                }
                else
                {
                    let url = imageURL + result["poster_path"].stringValue
                    movies.append(Movie(name: name, url: url, originalLang: originalLang, releaseDate: releaseDate, rating: rating, id: id, description: description))
                }

        }
    }
    
    //show tv shows button
    @IBAction func tvButton(_ sender: Any) {
        
        let searchText = searchBar.text?.replacingOccurrences(of: " ", with: "+")

        //alert if search hasn't been entered
        if (searchBar.text == "") {
            let ac = UIAlertController(title: "Oops!", message: "You must enter a search before you can see TV Shows" , preferredStyle: .alert)
            ac.addAction(UIAlertAction(title:"OK", style: .default, handler:nil))
            present(ac, animated:true, completion:nil)
        }
        else {
            self.spinner.startAnimating()
            self.spinner.isHidden = false
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.TvShow(name: searchText!)
                self.cacheImages()
                DispatchQueue.main.async {
                    self.movieCollectionView.reloadData()
                    self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                }
            }
        }

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Details", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Details" {
            let destination = segue.destination as? MovieDetails
            let movieIndex = sender as! Int
            destination!.movieInfo = movies[movieIndex]
        }
    }
 
    private func getJSON(path: String) -> JSON {
        guard let url = URL(string: path) else { return JSON.null }
        do
        {
            let data = try Data(contentsOf: url)
            return try JSON(data: data)
        } catch
        {
            return JSON.null
        }
    }
    
    
    //cache Images
    func cacheImages() {
        for item in movies
        {
            let url = URL(string: item.url)
            let data = try? Data(contentsOf: url!)
            if (data == nil)
            {
                theImageCache.append(#imageLiteral(resourceName: "Null"))
                continue
            }
            let image = UIImage(data: data!)
            theImageCache.append(image!)
        }
    }
    
}
