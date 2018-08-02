//
//  Recipes.swift
//  Reciplease
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation

struct SearchQueryResult : Decodable {
    let matches : [Recipes]?
}

struct Recipes : Decodable {
    let imageUrlsBySize : [String: String]?
    let recipeName : String?
    let ingredients : [String]?
    let id : String?
    let totalTimeInSeconds : Int?
    let rating : Int?
}
