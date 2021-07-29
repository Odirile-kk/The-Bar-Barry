//
//  BarTableViewController.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/07/21.
//

import UIKit

class BarTableViewController: UITableViewController {
    
    //call the apiService
    var drinks = Drinks()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loader = self.loader()
        //call the function where you downlaod the data from the json
        drinks.getData {
            DispatchQueue.main.async {
                self.navigationItem.title = "Drinks List"
                self.tableView.reloadData()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.stopLoader(loader: loader)
        }
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.drinkss.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! ViewTableViewCell
        
        if indexPath.row == drinks.drinkss.count-1 && drinks.alphabetIndex < drinks.alphabet.count {
            drinks.getData {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Drinks List"
                    self.tableView.reloadData()
                }
            }
            
        }
        let bar = drinks.drinkss[indexPath.row]
        cell.nameLbl.text = "\(bar.strDrink)"
        cell.categoryLbl.text = "\(bar.strCategory)"
        cell.drinkImg.downloaded(from: "\(bar.strDrinkThumb)")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            let destination = segue.destination as? DetailViewController
            let selectedIndexPath = self.tableView.indexPathForSelectedRow!
            destination?.drinker = drinks.drinkss[selectedIndexPath.row]
            
        }
    }
    
}


