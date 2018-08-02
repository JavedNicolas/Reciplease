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

    var search : Search!

    override func setUp() {
        super.setUp()
        search = Search()
    }
    
    func testGivenIngredientListIsEmptyWhenWeAddAnIngredientThenTheListIsNotEmpty() {
        // Given

        // When
        search.addIngredient("Tomato")

        // Then
        XCTAssertNotEqual(search.ingredientList.count, 0)
    }

    func testGivenIngredientListIsNotEmptyWhenWeRemoveAnIngredientThenTheIngredientAsBeenRemovedAndTheListIsOneElementShorter() {
        // Given
        search.addIngredient("Tomato")
        let numberOfIngredient = search.ingredientList.count

        // When
        search.removeIngredient("Tomato")
        let numberOfIngredientAfterRemove = search.ingredientList.count

        // Then
        XCTAssertEqual(numberOfIngredientAfterRemove, numberOfIngredient - 1)
    }

    func testGivenIngredientListIsNotEmptyWhenWeWantToEmptyItThenTheListIsEmpty() {
        // Given
        search.addIngredient("Tomato")
        search.addIngredient("Bacon")

        // When
        search.clearIngredientList()
        let numberOfIngredient = search.ingredientList.count

        // Then
        XCTAssertEqual(numberOfIngredient, 0)
    }
    
}
