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
    private var yummlySession : YummlySession

    // -------------- Init
    init(yummlySession : YummlySession){
        self.yummlySession = yummlySession
    }

    // -------------- functions
    /**
     Query for A precise recipe from an id

    - Parameters:
        - id : id of the recipe to retrieve
     */
    func queryForRecipe(forRecipeID id: String, completionHandler: @escaping (Bool, RecipeDetail?) -> ()){
        let url = URL(string: yummlySession.apiUrlString)!

        yummlySession.request(url: url) { data in
            let parsedResult = self.handleAnswer(data, type: RecipeDetail.self)
            guard let recipeDetail = parsedResult.recipe as? RecipeDetail else {
                completionHandler(false, nil)
                return
            }
            completionHandler(parsedResult.success, recipeDetail)
        }
    }

    /**
     Query for recipes from ingredients

     - Parameters:
        - forIngredients : An Array of String which contains ingredient to search for.
     */
    func queryForSearchRecipes(forIngredients: [String], completionHandler: @escaping (Bool, [RecipeSummary]?) -> ()) {
        let ingredientString = createQueryFromSearch(ingredients: forIngredients)
        guard let ingredientsWithPercent = ingredientString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        let url = URL(string: yummlySession.apiUrlString + ingredientsWithPercent)!

        yummlySession.request(url: url) { data in
            let parsedResult = self.handleAnswer(data, type: RecipeSummary.self)
            guard let searchQueryResult = parsedResult.recipe as? SearchQueryResult else {
                completionHandler(false, nil)
                return
            }
            completionHandler(parsedResult.success, searchQueryResult.matches)
        }
    }

    /**
     Handler the result of the que query
     - Parameters:
        - data : Data from the Alamofire request request
        - type: The type of the Recipe struct which you send (like RecipeSumary) as a Type Variable
     - Returns:
        success: The query ended in succes or not (a Boolean)
        Recipe: An struct of the Recipe type which contains the parsed Data or nil
     */
    private func handleAnswer(_ data : DataResponse<Any>, type: Recipe.Type) -> (success :Bool, recipe: Recipe?) {

        if data.response?.statusCode != 200 {
            return (false, nil)
        }
        switch data.result {
            case .success:
                var parsedQuery : Recipe?
                do {
                    if type == RecipeDetail.self {
                        parsedQuery = try JSONDecoder().decode(RecipeDetail.self, from: data.data!)
                    }else if type == RecipeSummary.self {
                        parsedQuery = try JSONDecoder().decode(SearchQueryResult.self, from: data.data!)
                    }
                }catch {
                    return (false, nil)
                }

                if let parsed = parsedQuery {
                    return (true, parsed)
                }else {
                    return (false, nil)
                }
            case .failure:
                return (false, nil)
        }
    }

    /** create a query with the ingredient list **/
    private func createQueryFromSearch(ingredients: [String]) -> String {
        var ingredientString = ""
        for ingredient in ingredients {
            ingredientString += YummlyConstant.ingredient + ingredient
        }
        return ingredientString
    }
}
