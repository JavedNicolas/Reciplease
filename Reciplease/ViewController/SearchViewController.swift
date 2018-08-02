//
//  SecondViewController.swift
//  Reciplease
//
//  Created by Nicolas on 01/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // ---------  Outlet
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var ingredientTableView: UITableView!

    // --------- Attribut
    var search = Search()

    // --------- Actions
    @IBAction func add(_ sender: Any) {
        if let newIngredient = ingredientTextField.text {
            search.addIngredient(newIngredient)
            ingredientTextField.text = ""
        }
    }
    
    @IBAction func clear(_ sender: Any) {
        search.clearIngredientList()
    }

    // --------- functions

    private func addObserverForIngredientListChange() {
        let notificationName = Notification.Name(rawValue: "Ingredient List Changed")
        NotificationCenter.default.addObserver(self, selector: #selector(ingredientListChanged), name: notificationName ,object: nil)
    }

    @objc func ingredientListChanged() {
        ingredientTableView.reloadData()
    }

    // --------- Controller func
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserverForIngredientListChange()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

