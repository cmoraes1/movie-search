//
//  favorites.swift
//  Lab4
//
//  Created by Camilla Moraes on 10/7/17.
//  Copyright © 2017 Camilla Moraes. All rights reserved.
//

import UIKit

class Favorites: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var titles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        setupTableView()
        
        let UserDefault = UserDefaults.standard
        var favs = UserDefault.array(forKey: "favorites") as? [String]
        
        //check to make sure is favorites is empty - if no key associated with favorites set it equal to string array
        if favs == nil
        {
            favs = []
        }

        self.titles = favs!
        
        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        let UserDefault = UserDefaults.standard
        let favs = UserDefault.array(forKey: "favorites") as? [String]
        self.titles = favs!
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    //fill table view cells with titles
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = titles[indexPath.row]

        return cell
    }
    
    //delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //remove from table
        self.titles.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
        let UserDefault = UserDefaults.standard
        var favs = UserDefault.array(forKey: "favorites") as! [String]
        
        //remove from array and update it
        favs.remove(at: indexPath.row)
        UserDefaults.standard.set(favs, forKey: "favorites")

        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    
    @IBAction func clearButton(_ sender: Any) {
        // got the next two lines of code from https://stackoverflow.com/questions/545091/clearing-nsuserdefaults
        let bundle = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: bundle)
        
        titles.removeAll()
        tableView.reloadData()
    }

}
