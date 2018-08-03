//
//  SearchResultDataSource.swift
//  Reciplease
//
//  Created by Nicolas on 03/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

extension SearchResultViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipes = recipes else {
            return 0
        }
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as? RecipeCell else {
            return UITableViewCell()
        }

        guard let recipes = recipes, let name = recipes[indexPath.row].recipeName,
            let ingredients = recipes[indexPath.row].ingredients?.joined(separator: ","),
            let duration = recipes[indexPath.row].totalTimeInSeconds, let rating =  recipes[indexPath.row].rating,
            let imageUrlString = recipes[indexPath.row].imageUrlsBySize else {
            return UITableViewCell()
        }

        cell.title?.text = name
        cell.ingredients?.text = ingredients
        cell.duration?.text = String(duration / 60) + " min"
        cell.rating?.text = String(rating)
        let rightSizeUrl = String((imageUrlString["90"]?.dropLast(5))!) + "s1200"
        let url = URL(string: rightSizeUrl)
        let data = try? Data(contentsOf: url!)

        if let data = data {
            let image = UIImage(data: data)
            cell.imageView?.contentMode = UIViewContentMode.scaleAspectFill 
            cell.imageView?.image = image
        }else {
            cell.imageView?.image = #imageLiteral(resourceName: "Recipes-Image")
        }

        return cell
    }
}
