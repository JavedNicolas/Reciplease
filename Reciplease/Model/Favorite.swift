//
//  Favorite.swift
//  Reciplease
//
//  Created by Nicolas on 09/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import CoreData

class Favorite: NSManagedObject {
    /** return all the favorite **/
    var getAllFavorite : [RecipeSummary]  {
        get {
            return getFavorite()
        }
    }

     /** Get Favorite from local database **/
    private func getFavorite() -> [RecipeSummary] {
        if let favorites = CoreDataManager.shared.getFavories() {
            return  createRecipesFromFavorite(favorites: favorites)
        }else {
            return []
        }
    }

     /** Turn a Favorite entity in a RecipeSummary var **/
    func createRecipesFromFavorite(favorites: [Favorite]) -> [RecipeSummary] {
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
}
