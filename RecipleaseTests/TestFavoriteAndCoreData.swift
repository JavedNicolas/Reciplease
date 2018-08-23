//
//  TestFavorite.swift
//  RecipleaseTests
//
//  Created by Nicolas on 20/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import XCTest
@testable import Reciplease

class TestFavoriteAndCoreData: XCTestCase {

    
    override func setUp() {
        super.setUp()
        CoreDataManager.shared.managerForTest()
        removeAllFavorite()
    }

    func removeAllFavorite() {
        let favorites = CoreDataManager.shared.getFavories()
        guard let favoritesArray = favorites else {
            return
        }

        let recipes = Favorite().createRecipesFromFavorite(favorites: favoritesArray)
        for recipe in recipes {
            CoreDataManager.shared.removeFavorite(recipe: recipe)
        }
    }

    func testGivenWeWantToGetAllFavoriteWhenWeAskForThemThenWeGetAllFavorite() {
        // Given
        let recipes = try! JSONDecoder().decode(SearchQueryResult.self, from: FakeData(bundleName: "IngredientQueryResult").correctData)
        CoreDataManager.shared.saveFavorite(recipe: recipes.matches?.first)

        // When
        let favorites = Favorite().getAllFavorite

        // Then
        XCTAssertNotEqual(favorites.count, 0 )
    }

    func testGivenWeWantToGetAllFavoriteWhileThereIsZeroFavoriteWhenWeAskForThemThenWeAnEmptyArray() {
        // Given

        // When
        let favorites = Favorite().getAllFavorite

        // Then
        XCTAssertEqual(favorites.count, 0)
    }

    
}
