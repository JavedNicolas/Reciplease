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
    var ingredient = Ingredients()
    lazy var api = YummlyAPI(yummlySession: YummlySession(endPoint: YummlyConstant.endPointForSearch))

    // --------- Actions
    @IBAction func add(_ sender: Any) {
        if let newIngredient = ingredientTextField.text {
            let newIngredients = newIngredient.split(separator: ",")
            for ingredientToAdd in newIngredients {
                if ingredientToAdd.first == " " {
                    ingredient.addIngredient(String(ingredientToAdd.dropFirst()))
                }else {
                    ingredient.addIngredient(String(ingredientToAdd))
                }
            }
            ingredientTextField.text = ""
        }
    }
    
    @IBAction func clear(_ sender: Any) {
        ingredient.clearIngredientList()
    }

    @IBAction func searchForRecipes(_ sender: Any) {
        api.queryForSearchRecipes(forIngredients: ingredient.ingredientList) { (success, recipes) in
            if success {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let searchResultViewController = storyboard.instantiateViewController(withIdentifier: "search_Result") as? SearchResultViewController
                if let nextViewController = searchResultViewController {
                    nextViewController.recipes = recipes
                    self.present(nextViewController, animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func dismissKeyboard(_ sender: Any) {
        ingredientTextField.resignFirstResponder()
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
        ingredientTableView.tableFooterView = UIView()
        addObserverForIngredientListChange()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

