//
//  Constant.swift
//  Reciplease
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation

struct YummlyConstant {
    static let endPointForSearch = "https://api.yummly.com/v1/api/recipes?"
    static let endPointForRecipe = "https://api.yummly.com/v1/api/recipe/"
    static let appID = "_app_id=" + YummlyIDs.appId
    static let apiKey = "&_app_key=" + YummlyIDs.key
    static let ingredient = "&allowedIngredient[]="
}
