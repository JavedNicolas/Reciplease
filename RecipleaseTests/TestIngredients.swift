//
//  TestSearch.swift
//  RecipleaseTests
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import XCTest
@testable import Reciplease

class TestSearch: XCTestCase {

    var ingredients : Ingredients!

    override func setUp() {
        super.setUp()
        ingredients = Ingredients()
    }
    
    func testGivenIngredientListIsEmptyWhenWeAddAnIngredientThenTheListIsNotEmpty() {
        // Given

        // When
        ingredients.addIngredient("Tomato")

        // Then
        XCTAssertNotEqual(ingredients.ingredientList.count, 0)
    }

    func testGivenIngredientListIsNotEmptyWhenWeRemoveAnIngredientThenTheIngredientAsBeenRemovedAndTheListIsOneElementShorter() {
        // Given
        ingredients.addIngredient("Tomato")
        let numberOfIngredient = ingredients.ingredientList.count

        // When
        ingredients.removeIngredient("Tomato")
        let numberOfIngredientAfterRemove = ingredients.ingredientList.count

        // Then
        XCTAssertEqual(numberOfIngredientAfterRemove, numberOfIngredient - 1)
    }

    func testGivenIngredientListIsNotEmptyWhenWeWantToEmptyItThenTheListIsEmpty() {
        // Given
        ingredients.addIngredient("Tomato")
        ingredients.addIngredient("Bacon")

        // When
        ingredients.clearIngredientList()
        let numberOfIngredient = ingredients.ingredientList.count

        // Then
        XCTAssertEqual(numberOfIngredient, 0)
    }
    
}
