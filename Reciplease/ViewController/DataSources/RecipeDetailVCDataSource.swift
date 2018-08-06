//
//  RecipeDetailVCDataSource.swift
//  Reciplease
//
//  Created by Nicolas on 06/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

extension RecipeDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipeDetail = recipeDetail, let ingredients = recipeDetail.ingredientLines else {
            return 0
        }
        return ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredient"),let recipeDetail = recipeDetail,
            let ingredients = recipeDetail.ingredientLines else {
            return UITableViewCell()
        }

        cell.textLabel?.text = ingredients[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ingredients : "
    }


}
