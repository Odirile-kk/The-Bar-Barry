//
//  ViewController.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/07/20.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var drinkImg: UIImageView!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ingTxt: UITextView!
    @IBOutlet weak var recipTxt: UITextView!
    @IBOutlet weak var favBtn: UIButton!
    
    var drinker: Drink?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [FaveEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    
    
    @IBAction func favBtnTapped(_ sender: Any) {
        
        let checkRecord = checkIfExists((drinker?.idDrink)!)
        if checkRecord == false
        {
            addFavouriteCocktail((drinker?.idDrink)!)
            self.favBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
//            let alert = UIAlertController(title: "Added", message: "\((drinker?.strDrink)!) added to your favourites!", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true)
        }
        else
        {
            let alert = UIAlertController(title: nil , message: "Oops! Already exists.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { [weak self] _ in
                self?.deleteFavourite((self!.drinker?.idDrink)!)
                self!.favBtn.setImage(UIImage(systemName: "star"), for: .normal)
//                let notifier = UIAlertController(title: nil, message: "\((self!.drinker?.strDrink)!) drink removed from favorites", preferredStyle: .alert)
//                notifier.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                self!.present(notifier, animated: true)
            }))
            self.present(alert, animated: true)
            
        }
    }
    
    func favBtnStatus( _ itemID: String)
    {
        let checkRecord = checkIfExists((drinker!.idDrink)!)
        if checkRecord == false {
            self.favBtn.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else
        {
            self.favBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
    }
    
    func addFavouriteCocktail( _ itemID: String)
    {
        let newItem = FaveEntity(context: context) //The context from line 20
        newItem.barID = itemID
        do
       {
        try context.save()
        print("Favourite Cocktail Saved")
       }
        catch
        {
            print("Save Error: \(error.localizedDescription)")
        }
    }
    
    func checkIfExists( _ itemID: String) -> Bool
    {
        var numRecords:Int = 0
        do
       {
        let request: NSFetchRequest<FaveEntity> = FaveEntity.fetchRequest()
        request.predicate = NSPredicate(format: "barID == %@", itemID)
        numRecords = try context.count(for: request)
        print("We're counting our items: \(numRecords)")
       }
        catch
        {
            print("Error in checking items: \(error.localizedDescription)")
        }
        if numRecords == 0
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    func deleteFavourite( _ itemID: String)
    {
        do{
            let request: NSFetchRequest<FaveEntity> = FaveEntity.fetchRequest()
            request.predicate = NSPredicate(format: "barID == %@", itemID)
            models = try context.fetch(request)
        }
        catch
        {
        }
        context.delete(models[0])
        
        do
       {
        try context.save()
       }
        catch
        {
            print("Save Error: \(error.localizedDescription)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favBtnStatus((drinker!.idDrink)!)
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

