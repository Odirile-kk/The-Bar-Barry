//
//  VirginTableViewController.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/08/26.
//

import UIKit

class VirginTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    var activityIndicatorV = UIActivityIndicatorView()
    
    var barV = [Virgin]()
    var filteredDrinksV = [Virgin]()
    
    var dpV : DownloadData?
    let delegateV = BarBerry.VirginDataProvider()
    
    let searchControllerV = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupActivityIndicator()
        activityIndicatorV.startAnimating()
        self.view.isUserInteractionEnabled = false
        //call the function where you downlaod the data from the json
        delegateV.getData {
            DispatchQueue.main.async {
                self.navigationItem.title = "Drinks List"
                self.tableView.reloadData()
                
                self.activityIndicatorV.stopAnimating()
                self.view.isUserInteractionEnabled = true
            }
        }
        searchControllerV.searchResultsUpdater = self
        
        definesPresentationContext = true
        tableView.tableHeaderView = searchControllerV.searchBar
        searchControllerV.searchBar.tintColor = UIColor.white
        searchControllerV.searchBar.barTintColor = UIColor.black
    }
    
    func setupActivityIndicator() {
        
        activityIndicatorV.center = self.view.center
        activityIndicatorV.hidesWhenStopped = true
        activityIndicatorV.style = .large
        activityIndicatorV.color = UIColor.white
        view.addSubview(activityIndicatorV)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchControllerV.isActive && searchControllerV.searchBar.text != "" {
            return filteredDrinksV.count
        }
        return delegateV.barV.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "virgin", for: indexPath) as! VirginTableViewCell

        let vDrink: Virgin!
        
        if searchControllerV.isActive && searchControllerV.searchBar.text != "" {
            vDrink = filteredDrinksV[indexPath.row]
        }
        else {
            vDrink = delegateV.barV[indexPath.row]
        }
        
//        if indexPath.row == delegateV.barV.count-1 && delegateV.alphabetIndex < delegateV.alphabet.count {
//            delegateV.getData {
//                DispatchQueue.main.async {
//                    self.navigationItem.title = "Drinks List"
//                    self.tableView.reloadData()
//                }
//            }
        
       // let drinks = barV[indexPath.row]
        
        
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
        filteredDrinksV = delegateV.barV.filter { vDrink in
            return
                vDrink.strDrink.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    

    func updateSearchResults(for searchController: UISearchController) {
        filterDrink(for: searchControllerV.searchBar.text ?? "")
    }
}
