//
//  NonVirginTableViewController.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/08/26.
//

import UIKit

class NonVirginTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    var activityIndicatorNV = UIActivityIndicatorView()
    
    var nvBar = [Virgin]()
    var filteredDrinksNV = [Virgin]()
    
    var dpV : DownloadData?
    let delegateNV = BarBerry.NonVirginDataProvider()
    
    let searchControllerNV = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupActivityIndicator()
        activityIndicatorNV.startAnimating()
        self.view.isUserInteractionEnabled = false
        //call the function where you downlaod the data from the json
        delegateNV.getData {
            DispatchQueue.main.async {
                self.navigationItem.title = "Drinks List"
                self.tableView.reloadData()
                
                self.activityIndicatorNV.stopAnimating()
                self.view.isUserInteractionEnabled = true
            }
        }
        searchControllerNV.searchResultsUpdater = self
        
        definesPresentationContext = true
        tableView.tableHeaderView = searchControllerNV.searchBar
        searchControllerNV.searchBar.tintColor = UIColor.white
        searchControllerNV.searchBar.barTintColor = UIColor.black
    }
    
    func setupActivityIndicator() {
        
        activityIndicatorNV.center = self.view.center
        activityIndicatorNV.hidesWhenStopped = true
        activityIndicatorNV.style = .large
        activityIndicatorNV.color = UIColor.white
        view.addSubview(activityIndicatorNV)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchControllerNV.isActive && searchControllerNV.searchBar.text != "" {
            return filteredDrinksNV.count
        }
        return delegateNV.nvBar.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "virgin", for: indexPath) as! VirginTableViewCell

        let vDrink: Virgin!
        
        if searchControllerNV.isActive && searchControllerNV.searchBar.text != "" {
            vDrink = filteredDrinksNV[indexPath.row]
        }
        else {
            vDrink = delegateNV.nvBar[indexPath.row]
        }
        
//        if indexPath.row == delegateV.barV.count-1 && delegateV.alphabetIndex < delegateV.alphabet.count {
//            delegateV.getData {
//                DispatchQueue.main.async {
//                    self.navigationItem.title = "Drinks List"
//                    self.tableView.reloadData()
//                }
//            }
        
        //let drinks = bar[indexPath.row]
        
        
        cell.vTitle.text = "\(vDrink.strDrink)"
       // cell.vType.text = "\(vDrink.strCategory)"
        cell.vImg.downloaded(from: "\(vDrink.strDrinkThumb)")

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        performSegue(withIdentifier: "showDetailV", sender: nil)
//    }
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if let destination = segue.destination as? DetailViewController {
//            destination.drinker = delegateV.barV[(tableView.indexPathForSelectedRow?.row)!]
//        }
//    }
   
    private func filterDrink(for searchText: String) {
        filteredDrinksNV = delegateNV.nvBar.filter { vDrink in
            return
                vDrink.strDrink.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    

    func updateSearchResults(for searchController: UISearchController) {
        filterDrink(for: searchControllerNV.searchBar.text ?? "")
    }
}
