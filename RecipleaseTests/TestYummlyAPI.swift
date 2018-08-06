//
//  TestYummlyAPI.swift
//  RecipleaseTests
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import XCTest
@testable import Reciplease

class TestYummlyAPI: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    // ---------- Recipes List request test
    func testGivenWeNeedToSearchForRecipeBasedOnIngredientWhenWeMakeAResquestThenWeGetRecipes() {
        let fakeUrlSession = FakeUrlSession(data: FakeRecipeSearchData.correctData, response: FakeRecipeSearchData.reponseOK, error: nil)
        let yummlyApi = YummlyAPI(yummlySession: YummlySession(endPoint: "http://fakeurl.com"), session: fakeUrlSession)
        let expectation = XCTestExpectation(description: "Wait For Queue Change")

        yummlyApi.queryForSearchRecipes(forIngredients: ["tomato,eggs"], completionHandler:  { success, recipes in
            XCTAssertNotNil(recipes)
            XCTAssertTrue(success)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenWeNeedoSearchForRecipeBasedOnIngredientWhenWeMakeAResquestThenWeGetAnError() {
        let fakeUrlSession = FakeUrlSession(data: FakeRecipeSearchData.correctData, response: FakeRecipeSearchData.reponseOK, error: FakeRecipeSearchData.error)
        let yummlyApi = YummlyAPI(yummlySession: YummlySession(endPoint: "http://fakeurl.com"), session: fakeUrlSession)
        let expectation = XCTestExpectation(description: "Wait For Queue Change")

        yummlyApi.queryForSearchRecipes(forIngredients: [], completionHandler:  { success, recipes in
            XCTAssertNil(recipes)
            XCTAssertFalse(success)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenWeNeedoSearchForRecipeBasedIngredientWhenWeMakeAResquestThenWeGetAHTTPError() {
        let fakeUrlSession = FakeUrlSession(data: FakeRecipeSearchData.correctData, response: FakeRecipeSearchData.reponseKO, error: nil)
        let yummlyApi = YummlyAPI(yummlySession: YummlySession(endPoint: "http://fakeurl.com"), session: fakeUrlSession)
        let expectation = XCTestExpectation(description: "Wait For Queue Change")

        yummlyApi.queryForSearchRecipes(forIngredients: [], completionHandler:  { success, recipes in
            XCTAssertNil(recipes)
            XCTAssertFalse(success)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenWeNeedoSearchForRecipeBasedOnIngredientWhenWeMakeAResquestThenWeGetBadData() {
        let fakeUrlSession = FakeUrlSession(data: FakeRecipeSearchData.wrongData, response: FakeRecipeSearchData.reponseOK, error: nil)
        let yummlyApi = YummlyAPI(yummlySession: YummlySession(endPoint: "http://fakeurl.com"), session: fakeUrlSession)
        let expectation = XCTestExpectation(description: "Wait For Queue Change")

        yummlyApi.queryForSearchRecipes(forIngredients: [], completionHandler:  { success, recipes in
            XCTAssertNil(recipes)
            XCTAssertFalse(success)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    // ----------------- Recipe request test
    func testGivenWeNeedARecipeWhenWeMakeAResquestThenWeGetTheRecipeDetail() {
        let fakeUrlSession = FakeUrlSession(data: FakeRecipeData.correctData, response: FakeRecipeData.reponseOK, error: nil)
        let yummlyApi = YummlyAPI(yummlySession: YummlySession(endPoint: "http://fakeurl.com"), session: fakeUrlSession)
        let expectation = XCTestExpectation(description: "Wait For Queue Change")

        yummlyApi.queryForRecipe(forRecipeID: "id", completionHandler:  { success, recipe in
            XCTAssertNotNil(recipe)
            XCTAssertTrue(success)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenWeeedARecipeWhenWeMakeAResquestThenWeGetAnError() {
        let fakeUrlSession = FakeUrlSession(data: FakeRecipeData.correctData, response: FakeRecipeData.reponseOK, error: FakeRecipeData.error)
        let yummlyApi = YummlyAPI(yummlySession: YummlySession(endPoint: "http://fakeurl.com"), session: fakeUrlSession)
        let expectation = XCTestExpectation(description: "Wait For Queue Change")

        yummlyApi.queryForRecipe(forRecipeID: "id", completionHandler:  { success, recipe in
            XCTAssertNil(recipe)
            XCTAssertFalse(success)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenWeNeedARecipeWhenWeMakeAResquestThenWeGetAHTTPError() {
        let fakeUrlSession = FakeUrlSession(data: FakeRecipeData.correctData, response: FakeRecipeData.reponseKO, error: nil)
        let yummlyApi = YummlyAPI(yummlySession: YummlySession(endPoint: "http://fakeurl.com"), session: fakeUrlSession)
        let expectation = XCTestExpectation(description: "Wait For Queue Change")

        yummlyApi.queryForRecipe(forRecipeID: "id", completionHandler:  { success, recipe in
            XCTAssertNil(recipe)
            XCTAssertFalse(success)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGivenWeNeedARecipeWhenWeMakeAResquestThenWeGetBadData() {
        let fakeUrlSession = FakeUrlSession(data: FakeRecipeData.wrongData, response: FakeRecipeData.reponseOK, error: nil)
        let yummlyApi = YummlyAPI(yummlySession: YummlySession(endPoint: "http://fakeurl.com"), session: fakeUrlSession)
        let expectation = XCTestExpectation(description: "Wait For Queue Change")

        yummlyApi.queryForRecipe(forRecipeID:"id", completionHandler:  { success, recipe in
            XCTAssertNil(recipe)
            XCTAssertFalse(success)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }
}
