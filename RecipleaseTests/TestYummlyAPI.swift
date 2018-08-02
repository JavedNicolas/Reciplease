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

    func testGivenWeNeedARecipeBaseOnIngredientWhenWeMakeAResquestWeGetRecipes() {
        let fakeUrlSession = FakeUrlSession(data: FakeData.correctData, response: FakeData.reponseOK, error: nil)
        let yummlyApi = YummlyAPI(yummlySession: YummlySession(endPoint: "http://api.yummly.com/v1/api/recipes?"), session: fakeUrlSession)
        let expectation = XCTestExpectation(description: "Wait For Queue Change")

        yummlyApi.queryForSearchRecipes(forIngredients: [], completionHandler:  { success, recipes in
            XCTAssertNotNil(recipes)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

}
