//
//  FavoriteVCDelegate.swift
//  Reciplease
//
//  Created by Nicolas on 09/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit
import CoreData

extension FavoriteViewController: UITableViewDelegate {
    /** Open recipe detail when the cell has been selected **/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "detail") as? RecipeDetailViewController

        guard let nextVC = nextViewController, let recipe = recipeList, let id = recipe[indexPath.row].id,
            let cell = tableView.cellForRow(at: indexPath) as? RecipeCell else {
                return
        }

        cell.loading(isloading: true)

        let yummlySesson = YummlySession(endPoint: YummlyConstant.endPointForRecipe + id + "?")
        let yummlyApi = YummlyAPIService(yummlySession: yummlySesson)

        yummlyApi.queryForRecipe(forRecipeID: id) { (success, recipeDetail) in

            if success {
                nextVC.recipe = recipe[indexPath.row]
                nextVC.recipeDetail = recipeDetail
                cell.loading(isloading: false)
                self.show(nextVC, sender: self)
            }else {
                cell.loading(isloading: false)
                self.errorHandling(error: ErrorList.unknowError)
            }
        }
    }

    /** Allow to remove Favorite from the table view and core data **/
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            guard let recipes = recipeList else {
                return
            }
            CoreDataManager.shared.removeFavorite(recipe: recipes[indexPath.row])

            recipeList = Favorite().getAllFavorite

            guard let recipeList = recipeList else {
                return
            }
            if recipeList.count <= 0 {
                displayEmptyListLabel(display: true)
            }else {
                displayEmptyListLabel(display: false)
            }
            
            tableView.reloadData()    
        default:
            return
        }
    }
}
