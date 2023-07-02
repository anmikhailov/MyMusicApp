//
//  FavoritesViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 30.06.2023.
//

import UIKit

class FavoritesViewController: BaseViewController, FavoritesViewInput {
    
    var favoritesView = FavoritesView()
    var output: FavoritesViewOutput!
    
    var favoritesItems: [String] = []
    
    //MARK: - Life cycles
    override func loadView() {
        super.loadView()
        
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Resources.Strings.NavBar.favorites
        
        favoritesView.favoritesTableView.dataSource = self
        favoritesView.favoritesTableView.delegate = self
        
        output.requestDataForTableView()
    }
    
    //MARK: - Input
    func fillDataForTableView(with inputArray: [String]) {
        favoritesItems = inputArray
    }
}

//MARK: - TableView methods extension
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = .backgroundColor
        cell.textLabel?.text = favoritesItems[indexPath.row]
        
        return cell
    }
    
    
}
