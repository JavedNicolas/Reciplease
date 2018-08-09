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
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "detail") as? RecipeDetailViewController

        guard let nextVC = nextViewController, let recipe = recipeList, let id = recipe[indexPath.row].id else {
            return indexPath
        }

        let yummlySesson = YummlySession(endPoint: YummlyConstant.endPointForRecipe + id + "?")
        let yummlyApi = YummlyAPI(yummlySession: yummlySesson)

        yummlyApi.queryForRecipe(forRecipeID: id) { (success, recipeDetail) in
            if success {
                nextVC.recipe = recipe[indexPath.row]
                nextVC.recipeDetail = recipeDetail
                self.present(nextVC, animated: true, completion: nil)
            }
        }

        return indexPath
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            removeFavorite(row: indexPath.row)
            
        default:
            return
        }
    }
}
