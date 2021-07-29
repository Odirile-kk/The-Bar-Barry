//
//  ApiServiceCall.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/07/20.
//

import Foundation
import UIKit


class Drinks {
    
    struct DrinkArray: Decodable {
        let drinks: [Drink]
    }

    //create an array that holds all the alphabets to call all the drinks in the list
    let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    //start from a
    var alphabetIndex = 0
  
    //call the struct that holds the drinks in a array
    var drinkss: [Drink] = []
    
    var urlBase = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f="
    var urlString = ""
    var isFetching = false
    
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
                self.drinkss += returned.drinks
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

extension UITableViewController {
    
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: "loading...", message: nil, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        return alert
    }
    
    func stopLoader(loader: UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
    
}
        
   
