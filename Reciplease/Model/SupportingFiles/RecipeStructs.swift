//
//  Recipes.swift
//  Reciplease
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation

struct SearchQueryResult : Decodable, Recipe {
    let matches : [RecipeSummary]?
}

struct RecipeSummary : Decodable, Recipe {
    let imageUrlsBySize : [String: String]?
    let recipeName : String?
    let ingredients : [String]?
    let id : String?
    let totalTimeInSeconds : Int?
    let rating : Int?
}

struct RecipeDetail : Decodable, Recipe {
    let yield : String?
    let source : urls?
    let ingredientLines : [String]?
}

struct urls : Decodable {
    let sourceRecipeUrl: String?
    let sourceSiteUrl : String?
}

