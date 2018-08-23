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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!

    // --------- Attribut
    internal var ingredient = Ingredients()
    private var emptyListLabel : UILabel?
    lazy var api = YummlyAPIService(yummlySession: YummlySession(endPoint: YummlyConstant.endPointForSearch))

    // --------- Actions
    /** Action which Add and ingredient when the matching button has been pressed **/
    @IBAction func add(_ sender: Any) {
        if let newIngredient = ingredientTextField.text {
            let newIngredients = newIngredient.components(separatedBy: ",")
            for ingredientToAdd in newIngredients {
                var ingredientTrimed = ingredientToAdd
                if ingredientTrimed.first == " " { ingredientTrimed = String(ingredientToAdd.dropFirst()) }
                if ingredientTrimed.last == " " { ingredientTrimed = String(ingredientToAdd.dropLast()) }

                ingredient.addIngredient(String(ingredientTrimed))
            }
            ingredientTextField.text = ""
        }
    }

    /** Clear the ingredient list **/
    @IBAction func clear(_ sender: Any) {
        ingredient.clearIngredientList()
    }

    /** Launch the search query and display SearchResultViewController **/
    @IBAction func searchForRecipes(_ sender: Any) {
        loading(isloading: true)
        api.queryForSearchRecipes(forIngredients: ingredient.ingredientList) { (success, recipes) in
            if success{
                self.loading(isloading: false)
                if let recipes = recipes, recipes.count <= 0 {
                    self.errorHandling(error: ErrorList.noResult)
                }else {
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let searchResultViewController = storyboard.instantiateViewController(withIdentifier: "search_Result") as? SearchResultViewController
                    if let nextViewController = searchResultViewController {
                        nextViewController.recipes = recipes
                        self.show(nextViewController, sender: self)
                    }
                }
            }else{
                self.loading(isloading: false)
                self.errorHandling(error: ErrorList.unknowError)
            }
        }
    }

    /** Hide keyboard on tapping anywhere in the VC **/
    @IBAction func dismissKeyboard(_ sender: Any) {
        ingredientTextField.resignFirstResponder()
    }

    // --------- functions
    /** Observe for ingredient list change **/
    private func addObserverForIngredientListChange() {
        let notificationName = Notification.Name(rawValue: "Ingredient List Changed")
        NotificationCenter.default.addObserver(self, selector: #selector(ingredientListChanged), name: notificationName ,object: nil)
    }

    /**
     Display the loading

     - Parameters:
        - isloading : A boolean to display or hide the loading
     */
    func loading(isloading: Bool) {
        searchButton.isHidden = isloading
        activityIndicator.isHidden = !isloading
        if isloading{
            activityIndicator.startAnimating()
        }else {
            activityIndicator.stopAnimating()
        }
    }

    /**
     display the label for when the list is empty

     - Parameters:
     - display : Boolean to display of hide the label
     */
    func displayEmptyListLabel(display: Bool) {
        let labelText = "The ingredient list is empty!\n Try adding ingredient with the textfield up there, or simply launch a search without ingredient."
        let label = emptyListLabelSetUp(display: display, tableView: ingredientTableView, textToDisplay: labelText)

        ingredientTableView.backgroundView = label
    }

    /** React to the ingredient list change by reloading the ingredient table view **/
    @objc func ingredientListChanged() {
        if ingredient.ingredientList.count <= 0 {
            displayEmptyListLabel(display: true)
        }else {
            displayEmptyListLabel(display: false)
        }
        ingredientTableView.reloadData()
    }

    // --------- Controller func
    override func viewDidLoad() {
        super.viewDidLoad()
        loading(isloading: false)
        ingredientTableView.tableFooterView = UIView()
        displayEmptyListLabel(display: true)
        addObserverForIngredientListChange()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

