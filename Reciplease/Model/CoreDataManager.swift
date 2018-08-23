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
    // ---------- singleton
    static var shared = CoreDataManager()
    private var viewContext = AppDelegate.viewContext

    // ---------- init
    private init() {}

    /** create a different context for test **/
    func managerForTest() {
        viewContext = AppDelegate.persistentConainer.newBackgroundContext()
    }

    // ---------- function
     /** save a Recipe in the Favorite local database **/
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

     /** remove a Favorite recipe from the local database **/
    func removeFavorite(recipe: RecipeSummary?) {
        guard let recipe = recipe, let id = recipe.id, let favorite = getFavorite(id: id) else {
            return
        }

        AppDelegate.viewContext.delete(favorite)
        saveContext()
    }

     /** Get a favorite from the local database with an id **/
    func getFavorite(id: String) -> Favorite?{
        var favorite : Favorite?

        let request : NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            favorite = try AppDelegate.viewContext.fetch(request).first
        }catch {
            return nil
        }

        return favorite
    }

     /** return all favorite from the local databse **/
    func getFavories() -> [Favorite]?{
        var favorites : [Favorite]?

        let request : NSFetchRequest<Favorite> = Favorite.fetchRequest()
        do {
            favorites = try AppDelegate.viewContext.fetch(request)
        }catch {
            return nil
        }

        return favorites
    }

     /** save the context **/
    private func saveContext() {
        do {
            try viewContext.save()
        } catch let error {
            print(error)
        }
    }
}
