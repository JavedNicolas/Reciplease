//
//  Search.swift
//  Reciplease
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation


class Ingredients {
    // -------- Attribut
    var ingredientList : [String] {
        didSet {
            sendNotification(name: "Ingredient List Changed")
        }
    }

    init() {
        ingredientList = []
    }

    // ----------- functions
    /** Add an ingredient to the Array */
    func addIngredient(_ ingredient : String) {
        if !containOnlySpaces(text: ingredient) {
            ingredientList.append(ingredient)
        }
    }

    /** remove an ingredient from the Array*/
    func removeIngredient(_ ingredient : String ) {
        for (index, item) in ingredientList.enumerated() {
            if item == ingredient {
                ingredientList.remove(at: index)
            }
        }
    }

    /** empty the ingredient Array */
    func clearIngredientList() {
        ingredientList = []
    }

    /** check if the ingredient is only space or empty **/
    func containOnlySpaces(text: String) -> Bool{
        for char in text {
            if char != " " {
                return false
            }
        }
        return true
    }

    /** create and send a notification */
    func sendNotification(name : String) {
        let notificationName = Notification.Name(name)
        let notification = Notification(name: notificationName)
        NotificationCenter.default.post(notification)
    }
}
