//
//  SearchResultVCDelegate.swift
//  Reciplease
//
//  Created by Nicolas on 03/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

extension SearchResultViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "detail") as? RecipeDetailViewController

        guard let nextVC = nextViewController, let recipe = recipes, let id = recipe[indexPath.row].id,
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
}
