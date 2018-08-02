//
//  Search.swift
//  Reciplease
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation


class Search {
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
    func addIngredient(_ ingredient : String) {
        ingredientList.append(ingredient)
    }

    func removeIngredient(_ ingredient : String ) {
        for (index, item) in ingredientList.enumerated() {
            if item == ingredient {
                ingredientList.remove(at: index)
            }
        }
    }

    func clearIngredientList() {
        ingredientList = []
    }

    func sendNotification(name : String) {
        let notificationName = Notification.Name(name)
        let notification = Notification(name: notificationName)
        NotificationCenter.default.post(notification)
    }
}
