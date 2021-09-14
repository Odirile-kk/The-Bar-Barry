//
//  FavTableViewController.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/08/06.
//

import UIKit

class FavTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var mod = [FaveEntity]()
    
    var barList = [Drink]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("This is the favourites screen")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("this is the count \(barList.count)")
        getCDCocktails()
        barList.removeAll()
        downloadCocktailDetaillsJSON {
            print("Attempting to download cocktails")
            self.tableView.reloadData()
            print("Done downloading cocktails")
            print("Fav returned \(self.barList.count)")
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getCDCocktails()
      {
        do
        {
          mod = try context.fetch(FaveEntity.fetchRequest())
        }
        catch
        {
          print("Error Getting items: \(error.localizedDescription)")
        }
      }
    
      func downloadCocktailDetaillsJSON(completed: @escaping () -> ())
      {
        for i in 0 ..< mod.count
        {
          let item = mod[i].barID as String?
          let queryURL = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(item!)"
          let url = URL(string: queryURL)!
          let urlSession = URLSession.shared
          let urlRequest = URLRequest(url: url)
            urlSession.dataTask(with: urlRequest)
          {
            data, urlResponse, error in
            if let error = error
            {
              print("Error: \(error.localizedDescription)")
              return
            }
            guard let unwrappedData = data else
            {
              print("No data")
              return
            }
            let jsonDecoder = JSONDecoder()
          do
          {
            let list = try jsonDecoder.decode(DrinkArray.self, from: unwrappedData).drinks
            //self.cocktailCollection = try jsonDecoder.decode(Cocktails.self, from: unwrappedData).drinks
            self.barList.append(contentsOf: list)
            DispatchQueue.main.async
            {
              completed()
            }
            } catch {
              print(error)
            }
          }.resume()
        }
      }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return barList.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FaveTableViewCell
        
        let drinks = barList[indexPath.row]
        
        
        cell.favLbl.text = "\(drinks.strDrink)"
        cell.favType.text = "\(drinks.strCategory)"
        cell.favImg.downloaded(from: "\(drinks.strDrinkThumb)")
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailViewController {
            destination.drinker = barList[(tableView.indexPathForSelectedRow?.row)!]
        }

    }
    

}
