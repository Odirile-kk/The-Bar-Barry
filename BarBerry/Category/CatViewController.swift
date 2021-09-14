//
//  CatViewController.swift
//  BarBerry
//
//  Created by Odirile Kekana on 2021/08/26.
//

import UIKit

class CatViewController: UIViewController {

    @IBOutlet weak var vBtn: UIButton!
    @IBOutlet weak var nvBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nvBtnTapped(_ sender: Any) {
        
        let nonVirginController = storyboard?.instantiateViewController(identifier: "NonVirgin") as! UITableViewController
        present(nonVirginController, animated: true, completion: nil)
    }
    
    @IBAction func vBtnTapped(_ sender: Any) {
        
        let virginController = storyboard?.instantiateViewController(identifier: "Virgin") as! UITableViewController
        present(virginController, animated: true, completion: nil)
    }
    

}
