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
    func queryForRecipePage(){

    }

    func queryForSearchRecipes(forIngredients: [String], completionHandler: @escaping (Bool, [Recipes]?) -> ()) {

        let ingredientString = createQuery(ingredients: forIngredients)
        guard let url = URL(string: yummlySession.apiUrlString + ingredientString) else {
            completionHandler(false, nil)
            return
        }
        task?.cancel()
        task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler(false, nil)
                    return
                }

                guard let reponse = response as? HTTPURLResponse, reponse.statusCode == 200 else {
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
