//
//  TestYummlyAPI.swift
//  RecipleaseTests
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import XCTest
@testable import Reciplease
import Alamofire

class TestYummlyAPI: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    // ---------- Recipes List request test
    func testGivenWeNeedToSearchForRecipeBasedOnIngredientWhenWeMakeAResquestThenWeGetRecipes() {
        let fakeResponse = FakeData(bundleName: "IngredientQueryResult").returnResponse(reponseType: ResponseType.goodResponse)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, response: fakeResponse))

        yummlyApi.queryForSearchRecipes(forIngredients: ["tomato,eggs"], completionHandler:  { success, recipes in
            XCTAssertNotNil(recipes)
            XCTAssertTrue(success)
        })
    }

    func testGivenWeNeedoSearchForRecipeBasedOnIngredientWhenWeMakeAResquestThenWeGetAnError() {
        let fakeResponse = FakeData(bundleName: "IngredientQueryResult").returnResponse(reponseType: ResponseType.error)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, response: fakeResponse))

        yummlyApi.queryForSearchRecipes(forIngredients: [], completionHandler:  { success, recipes in
            XCTAssertNil(recipes)
            XCTAssertFalse(success)
        })
    }

    func testGivenWeNeedoSearchForRecipeBasedIngredientWhenWeMakeAResquestThenWeGetAHTTPError() {
        let fakeResponse = FakeData(bundleName: "IngredientQueryResult").returnResponse(reponseType: ResponseType.badHttpResponse)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, response: fakeResponse))

        yummlyApi.queryForSearchRecipes(forIngredients: [], completionHandler:  { success, recipes in
            XCTAssertNil(recipes)
            XCTAssertFalse(success)
        })


    }

    func testGivenWeNeedoSearchForRecipeBasedOnIngredientWhenWeMakeAResquestThenWeGetBadData() {
        let fakeResponse = FakeData(bundleName: "IngredientQueryResult").returnResponse(reponseType: ResponseType.badData)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, response: fakeResponse))

        yummlyApi.queryForSearchRecipes(forIngredients: [], completionHandler:  { success, recipes in
            XCTAssertNil(recipes)
            XCTAssertFalse(success)
        })
    }

    // ----------------- Recipe request test
    func testGivenWeNeedARecipeWhenWeMakeAResquestThenWeGetTheRecipeDetail() {
        let fakeResponse = FakeData(bundleName: "RecipeQueryResult").returnResponse(reponseType: ResponseType.goodResponse)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, response: fakeResponse))

        yummlyApi.queryForRecipe(forRecipeID: "id", completionHandler:  { success, recipe in
            XCTAssertNotNil(recipe)
            XCTAssertTrue(success)
        })
    }

    func testGivenWeeedARecipeWhenWeMakeAResquestThenWeGetAnError() {
        let fakeResponse = FakeData(bundleName: "RecipeQueryResult").returnResponse(reponseType: ResponseType.error)


        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, response: fakeResponse))

        yummlyApi.queryForRecipe(forRecipeID: "id", completionHandler:  { success, recipe in
            XCTAssertNil(recipe)
            XCTAssertFalse(success)
        })
    }

    func testGivenWeNeedARecipeWhenWeMakeAResquestThenWeGetAHTTPError() {
        let fakeResponse = FakeData(bundleName: "RecipeQueryResult").returnResponse(reponseType: ResponseType.badHttpResponse)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, response: fakeResponse))

        yummlyApi.queryForRecipe(forRecipeID: "id", completionHandler:  { success, recipe in
            XCTAssertNil(recipe)
            XCTAssertFalse(success)
        })
    }

    func testGivenWeNeedARecipeWhenWeMakeAResquestThenWeGetBadData() {
        let fakeResponse = FakeData(bundleName: "RecipeQueryResult").returnResponse(reponseType: ResponseType.badData)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, response: fakeResponse))

        yummlyApi.queryForRecipe(forRecipeID:"id", completionHandler:  { success, recipe in
            XCTAssertNil(recipe)
            XCTAssertFalse(success)
        })
    }
}
