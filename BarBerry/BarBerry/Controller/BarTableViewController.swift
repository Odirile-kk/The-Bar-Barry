//
//  BarTableViewController.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/07/21.
//

import UIKit

class BarTableViewController: UITableViewController, UISearchResultsUpdating {
    
    
 
        //create an array that holds all the alphabets to call all the drinks in the list
        let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        //start from a
        var alphabetIndex = 0
      
        var urlBase = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f="
        var urlString = ""
        var isFetching = false
    
    var activityIndicator = UIActivityIndicatorView()
  
    //call the apiService
    var bar = [Drink]()
    var filteredDrinks = [Drink]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let loader = self.loader()
        setupActivityIndicator()
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        //call the function where you downlaod the data from the json
        getData {
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
            return self.filteredDrinks.count
        }
        return bar.count
                
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! ViewTableViewCell
        
        if indexPath.row == bar.count-1 && alphabetIndex < alphabet.count {
            getData {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Drinks List"
                    self.tableView.reloadData()
                }
            }
        }
        //let drinks = bar[indexPath.row]
        let drink: Drink!
        
        if searchController.isActive && searchController.searchBar.text != "" {
            drink = filteredDrinks[indexPath.row]
        }
        else {
            drink = bar[indexPath.row]
        }
            cell.nameLbl.text = "\(drink.strDrink)"
            cell.categoryLbl.text = "\(drink.strCategory)"
            cell.drinkImg.downloaded(from: "\(drink.strDrinkThumb)")
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            let destination = segue.destination as? DetailViewController
            let selectedIndexPath = self.tableView.indexPathForSelectedRow!
            
            destination?.drinker = bar[selectedIndexPath.row]
            
        }
    }
    
    func filterDrink(for searchText: String) {
        filteredDrinks = bar.filter { drink in
            return
                drink.strDrink.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterDrink(for: searchController.searchBar.text ?? "")
      }
    
    
    //create a function that downloads the json
        func getData(completed: @escaping () -> ()) {
          
            guard !isFetching else {
                print("Still fetching...")
                completed()
                return
            }
            isFetching = true

            //concatenate the base with the alphabets
            urlString = urlBase + alphabet[alphabetIndex]
            //increment
            alphabetIndex += 1
            //print to console the url being fetched
            print("\(urlString)")
            
            guard let url = URL(string: urlString)
            else {
                print("Error: URL not created")
                isFetching = false
                completed()
                return
            }
            
            let session = URLSession.shared
            let task = session.dataTask(with: url) {data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                
                do {
                    let returned = try JSONDecoder().decode(DrinkArray.self, from: data!)
                    self.bar += returned.drinks
                }
                catch {
                    print("Error")
                }
                self.isFetching = false
                completed()
            }
            
            task.resume()
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




