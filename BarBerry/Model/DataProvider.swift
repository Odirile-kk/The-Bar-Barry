//
//  DataProvider.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/08/26.
//

import Foundation

class DataProvider : DownloadData {
    
    var bar = [Drink]()
    
    //create an array that holds all the alphabets to call all the drinks in the list
    let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    //start from a
    var alphabetIndex = 0
    
    var urlBase = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f="
    var urlString = ""
    var isFetching = false
    
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
                print(error)
            }
            self.isFetching = false
            completed()
        }
        
        task.resume()
    }
}

//for virgin drinks
class VirginDataProvider: DownloadData {
    
    var barV = [Virgin]()
    
    var urlString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"
    
    func getData(completed: @escaping () -> ()) {
        
        guard let url = URL(string: urlString)
        else {
            print("Error: URL not created")
            completed()
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) {data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            do {
                let returned = try JSONDecoder().decode(VirginArray.self, from: data!)
                //self.barV += returned.drinks
            }
            catch {
                print("Error \(error.localizedDescription)")
            }
            completed()
        }
        
        task.resume()
    }
}

//For non virgin drinks
class NonVirginDataProvider: DownloadData {
    
    var nvBar = [Virgin]()
    var urlString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic"
    
    func getData(completed: @escaping () -> ()) {
        
        guard let url = URL(string: urlString)
        else {
            print("Error: URL not created")
            completed()
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) {data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            do {
                let returned = try JSONDecoder().decode(VirginArray.self, from: data!)
                DispatchQueue.main.async {
                    //self.nvBar.append(contentsOf: returned)
                    completed()
                }
               // self.nvBar.append(contentsOf: returned)
                //self.nvBar += returned.drinks
            }
            catch {
                print("Error \(error.localizedDescription)")
            }
            completed()
        }
        
        task.resume()
    }
}



