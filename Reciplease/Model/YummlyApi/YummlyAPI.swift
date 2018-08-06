//
//  YummlyAPI.swift
//  Reciplease
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation

class YummlyAPI {

    // ------------- Attributs
    private var task : URLSessionDataTask?
    private var session : URLSession
    private var yummlySession : YummlySession

    // -------------- Init
    init(yummlySession : YummlySession ,session: URLSession = URLSession(configuration: .default)){
        self.session = session
        self.yummlySession = yummlySession
    }

    // -------------- functions
    func queryForRecipe(forRecipeID id: String, completionHandler: @escaping (Bool, RecipeDetail?) -> ()){
        let url = URL(string: yummlySession.apiUrlString)!

        task?.cancel()
        task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let reponse = response as? HTTPURLResponse, reponse.statusCode == 200 else {
                    completionHandler(false, nil)
                    return
                }

                guard let data = data, error == nil else {
                    completionHandler(false, nil)
                    return
                }

                var parsedQuery : RecipeDetail?
                do {
                    parsedQuery = try JSONDecoder().decode(RecipeDetail.self, from: data)
                }catch {
                    completionHandler(false, nil)
                }

                if let parsed = parsedQuery {
                    completionHandler(true, parsed)
                }else {
                    completionHandler(false, nil)
                }
            }
        })
        task?.resume()
    }

    func queryForSearchRecipes(forIngredients: [String], completionHandler: @escaping (Bool, [RecipeSummary]?) -> ()) {

        let ingredientString = createQuery(ingredients: forIngredients)
        let url = URL(string: yummlySession.apiUrlString + ingredientString)!

        task?.cancel()
        task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let reponse = response as? HTTPURLResponse, reponse.statusCode == 200 else {
                    completionHandler(false, nil)
                    return
                }

                guard let data = data, error == nil else {
                    completionHandler(false, nil)
                    return
                }

                var parsedQuery : SearchQueryResult?
                do {
                    parsedQuery = try JSONDecoder().decode(SearchQueryResult.self, from: data)
                }catch {
                    completionHandler(false, nil)
                }

                if let parsed = parsedQuery {
                    completionHandler(true, parsed.matches)
                }else {
                    completionHandler(false, nil)
                }
            }
        })
        task?.resume()
    }


    private func createQuery(ingredients: [String]) -> String {
        var ingredientString = ""
        for ingredient in ingredients {
            ingredientString += YummlyConstant.ingredient + ingredient
        }
        return ingredientString
    }
}
