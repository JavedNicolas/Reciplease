//
//  YummlyAPI.swift
//  Reciplease
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation
import Alamofire

class YummlyAPIService {

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

        Alamofire.request(url).responseJSON { (data) in
            switch data.result {
            case .success:
                var parsedQuery : RecipeDetail?
                do {
                    parsedQuery = try JSONDecoder().decode(RecipeDetail.self, from: data.data!)
                }catch {
                    completionHandler(false, nil)
                }

                if let parsed = parsedQuery {
                    completionHandler(true, parsed)
                }else {
                    completionHandler(false, nil)
                }
            case .failure:
                completionHandler(false, nil)
            }
        }
    }

    func queryForSearchRecipes(forIngredients: [String], completionHandler: @escaping (Bool, [RecipeSummary]?) -> ()) {
        let ingredientString = createQuery(ingredients: forIngredients)
        guard let ingredientsWithPercent = ingredientString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        let url = URL(string: yummlySession.apiUrlString + ingredientsWithPercent)!

        Alamofire.request(url).responseJSON { (data) in
            switch data.result {
            case .success:
                var parsedQuery : SearchQueryResult?
                do {
                    parsedQuery = try JSONDecoder().decode(SearchQueryResult.self, from: data.data!)
                }catch {
                    completionHandler(false, nil)
                }

                if let parsed = parsedQuery {
                    completionHandler(true, parsed.matches)
                }else {
                    completionHandler(false, nil)
                }
            case .failure:
                completionHandler(false, nil)
            }
        }

    }


    private func createQuery(ingredients: [String]) -> String {
        var ingredientString = ""
        for ingredient in ingredients {
            ingredientString += YummlyConstant.ingredient + ingredient
        }
        return ingredientString
    }
}
