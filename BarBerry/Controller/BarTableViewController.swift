//
//  BarTableViewController.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/07/21.
//

import UIKit

class BarTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {

    
    var activityIndicator = UIActivityIndicatorView()
    
    //call the apiService
    var bar = [Drink]()
    var filteredDrinks = [Drink]()
    
    var dp : DownloadData?
    let delegate = BarBerry.DataProvider()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self 
        setupActivityIndicator()
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        //call the function where you downlaod the data from the json
        delegate.getData {
            DispatchQueue.main.async {
                self.navigationItem.title = "Drinks List"
                self.tableView.reloadData()
                
                self.activityIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
            }
        }
        searchController.searchResultsUpdater = self
        
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.black
        
    }
     
    func setupActivityIndicator() {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = UIColor.white
        view.addSubview(activityIndicator)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredDrinks.count
        }
        return delegate.bar.count
        
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! ViewTableViewCell
        
        
        let drink: Drink!
        
        if searchController.isActive && searchController.searchBar.text != "" {
            drink = filteredDrinks[indexPath.row]
        }
        else {
            drink = delegate.bar[indexPath.row]
        }
        
        if indexPath.row == delegate.bar.count-1 && delegate.alphabetIndex < delegate.alphabet.count {
            delegate.getData {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Drinks List"
                    self.tableView.reloadData()
                }
            }
        }
        //let drinks = bar[indexPath.row]
        
        
        cell.nameLbl.text = "\(drink.strDrink)"
        cell.categoryLbl.text = "\(drink.strCategory)"
        cell.drinkImg.downloaded(from: "\(drink.strDrinkThumb)")
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)


    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailViewController {
            destination.drinker = delegate.bar[(tableView.indexPathForSelectedRow?.row)!]
        }

    }
    
    private func filterDrink(for searchText: String) {
        filteredDrinks = delegate.bar.filter { drink in
            return
                drink.strDrink.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterDrink(for: searchController.searchBar.text ?? "")
 
    }
    
}


extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link)
        else {
            return
        }
        downloaded(from: url, contentMode: mode)
    }
}




