//
//  ViewController.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/07/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var drinkImg: UIImageView!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ingTxt: UITextView!
    @IBOutlet weak var recipTxt: UITextView!
    
    var drinker: Drink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI () {
        
        nameLbl.text = drinker?.strDrink
        
        //create a condition for non alcoholic drinks
        
        if drinker?.strAlcoholic != "Alcoholic" {
            typeLbl.text = "Non - Alcohol"
        }
        else {
            typeLbl.text = drinker?.strAlcoholic
        }
        
        
        recipTxt.text = drinker?.strInstructions
        //call the ingredient function inside the update function
        ingredients()
        
        //download the image from json
        
        guard let url = URL(string: drinker?.strDrinkThumb ?? "")
        else {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            self.drinkImg.image = UIImage(data: data)
        }
        catch {
            print("Cannot download image")
        }
    }
    
    
    func addIngredients(measure: String?, ingredient: String?) {
        
        guard measure != nil
        else {
            return
        }
        ingTxt.text += "\(measure!)"
        
        guard ingredient != nil
        else {
            return
        }
        ingTxt.text += "\(ingredient!)\n"
        
    }
    
    
    func ingredients() {
        
        ingTxt.text = ""
        
        addIngredients(measure: drinker?.strMeasure1, ingredient: drinker?.strIngredient1)
        addIngredients(measure: drinker?.strMeasure2, ingredient: drinker?.strIngredient2)
        addIngredients(measure: drinker?.strMeasure3, ingredient: drinker?.strIngredient3)
        addIngredients(measure: drinker?.strMeasure4, ingredient: drinker?.strIngredient4)
        addIngredients(measure: drinker?.strMeasure5, ingredient: drinker?.strIngredient5)
        addIngredients(measure: drinker?.strMeasure6, ingredient: drinker?.strIngredient6)
        addIngredients(measure: drinker?.strMeasure7, ingredient: drinker?.strIngredient7)
        addIngredients(measure: drinker?.strMeasure8, ingredient: drinker?.strIngredient8)
        addIngredients(measure: drinker?.strMeasure9, ingredient: drinker?.strIngredient9)
        addIngredients(measure: drinker?.strMeasure10, ingredient: drinker?.strIngredient10)
        addIngredients(measure: drinker?.strMeasure11, ingredient: drinker?.strIngredient11)
        addIngredients(measure: drinker?.strMeasure12, ingredient: drinker?.strIngredient12)
        addIngredients(measure: drinker?.strMeasure13, ingredient: drinker?.strIngredient13)
        addIngredients(measure: drinker?.strMeasure14, ingredient: drinker?.strIngredient14)
        addIngredients(measure: drinker?.strMeasure15, ingredient: drinker?.strIngredient15)
        
    }
    
    
}

