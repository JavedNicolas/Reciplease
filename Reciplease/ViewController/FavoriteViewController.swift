//
//  FirstViewController.swift
//  Reciplease
//
//  Created by Nicolas on 01/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    // --------- Outlet
    @IBOutlet weak var tableView: UITableView!

    // --------- Attribut
    internal var recipeList : [RecipeSummary]?


    // --------- VC function
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        getFavorite()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func getFavorite(){
        var favorites : [Favorite]?

        let request : NSFetchRequest<Favorite> = Favorite.fetchRequest()
        do {
            favorites = try AppDelegate.viewContext.fetch(request)
        }catch {

        }

        if let favorites = favorites {
            recipeList = createFavoriteRecipes(favorites: favorites)
        }
    }

    private func createFavoriteRecipes(favorites: [Favorite]) -> [RecipeSummary] {
        var recipes : [RecipeSummary] = []
        for favorite in favorites {
            guard let imageUrl = favorite.imageUrl else {
                return []
            }

            let favorite = favorite
            let image = ["90":imageUrl]
            let ingredientList = favorite.ingredients?.components(separatedBy: ",")
            let recipe = RecipeSummary(imageUrlsBySize: image, recipeName: favorite.recipeName, ingredients: ingredientList,
                                       id: favorite.id, totalTimeInSeconds: Int(favorite.timeInSeconds), rating: Int(favorite.rating))

            recipes.append(recipe)
        }

        return recipes
    }

    internal func removeFavorite(row: Int) {
        guard let recipes = recipeList, let id = recipes[row].id else {
            return
        }

        var favorite : Favorite?
        let request : NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            favorite = try AppDelegate.viewContext.fetch(request).first
        }catch {

        }
        if let favorite = favorite {
            AppDelegate.viewContext.delete(favorite)
            do {
                try AppDelegate.viewContext.save()
            } catch {
                
            }
            getFavorite()
            tableView.reloadData()
        }
    }
}

