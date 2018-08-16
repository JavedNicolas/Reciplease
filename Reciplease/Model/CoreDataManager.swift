//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Nicolas on 15/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    static var shared = CoreDataManager()

    private init() {}

    func saveFavorite(recipe: RecipeSummary?) {
        guard let recipe = recipe, let name = recipe.recipeName, let duration = recipe.totalTimeInSeconds,
            let rating = recipe.rating, let imageUrlString = recipe.imageUrlsBySize,
            let ingredients = recipe.ingredients, let id = recipe.id else {
                return
        }

        let favorite = Favorite(context: AppDelegate.viewContext)
        favorite.recipeName = name
        favorite.timeInSeconds = Int16(duration)
        favorite.rating = Int16(rating)
        favorite.imageUrl = String((imageUrlString["90"]?.dropLast(5))!) + "s1200"
        favorite.ingredients = ingredients.joined(separator: ",")
        favorite.id = id

        saveContext()
    }

    func removeFavorite(recipe: RecipeSummary?) {
        guard let recipe = recipe, let id = recipe.id, let favorite = getFavorite(id: id) else {
            return
        }

        AppDelegate.viewContext.delete(favorite)
        saveContext()
    }

    func getFavorite(id: String) -> Favorite?{
        var favorite : Favorite?

        let request : NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            favorite = try AppDelegate.viewContext.fetch(request).first
        }catch let error {
            print(error)
        }

        return favorite
    }

    func getFavories() -> [Favorite]?{
        var favorites : [Favorite]?

        let request : NSFetchRequest<Favorite> = Favorite.fetchRequest()
        do {
            favorites = try AppDelegate.viewContext.fetch(request)
        }catch {

        }

        return favorites
    }

    private func saveContext() {
        do {
            try AppDelegate.viewContext.save()
        } catch let error {
            print(error)
        }
    }
}
