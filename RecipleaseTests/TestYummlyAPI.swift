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
        let fakeResponse = FakeRecipeSearchData().returnResponse(reponseType: ResponseType.goodResponse)
        let fakeRequest = FakeRequest(reponse: fakeResponse)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, request: fakeRequest))

        yummlyApi.queryForSearchRecipes(forIngredients: ["tomato,eggs"], completionHandler:  { success, recipes in
            XCTAssertNotNil(recipes)
            XCTAssertTrue(success)
        })
    }

    func testGivenWeNeedoSearchForRecipeBasedOnIngredientWhenWeMakeAResquestThenWeGetAnError() {
        let fakeResponse = FakeRecipeSearchData().returnResponse(reponseType: ResponseType.error)
        let fakeRequest = FakeRequest(reponse: fakeResponse)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, request: fakeRequest))

        yummlyApi.queryForSearchRecipes(forIngredients: [], completionHandler:  { success, recipes in
            XCTAssertNil(recipes)
            XCTAssertFalse(success)
        })
    }

    func testGivenWeNeedoSearchForRecipeBasedIngredientWhenWeMakeAResquestThenWeGetAHTTPError() {
        let fakeResponse = FakeRecipeSearchData().returnResponse(reponseType: ResponseType.badHttpResponse)
        let fakeRequest = FakeRequest(reponse: fakeResponse)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, request: fakeRequest))

        yummlyApi.queryForSearchRecipes(forIngredients: [], completionHandler:  { success, recipes in
            XCTAssertNil(recipes)
            XCTAssertFalse(success)
        })


    }

    func testGivenWeNeedoSearchForRecipeBasedOnIngredientWhenWeMakeAResquestThenWeGetBadData() {
        let fakeResponse = FakeRecipeSearchData().returnResponse(reponseType: ResponseType.badData)
        let fakeRequest = FakeRequest(reponse: fakeResponse)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, request: fakeRequest))

        yummlyApi.queryForSearchRecipes(forIngredients: [], completionHandler:  { success, recipes in
            XCTAssertNil(recipes)
            XCTAssertFalse(success)
        })
    }

    // ----------------- Recipe request test
    func testGivenWeNeedARecipeWhenWeMakeAResquestThenWeGetTheRecipeDetail() {
        let fakeResponse = FakeRecipeData().returnResponse(reponseType: ResponseType.goodResponse)
        let fakeRequest = FakeRequest(reponse: fakeResponse)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, request: fakeRequest))

        yummlyApi.queryForRecipe(forRecipeID: "id", completionHandler:  { success, recipe in
            XCTAssertNotNil(recipe)
            XCTAssertTrue(success)
        })
    }

    func testGivenWeeedARecipeWhenWeMakeAResquestThenWeGetAnError() {
        let fakeResponse = FakeRecipeData().returnResponse(reponseType: ResponseType.error)
        let fakeRequest = FakeRequest(reponse: fakeResponse)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, request: fakeRequest))

        yummlyApi.queryForRecipe(forRecipeID: "id", completionHandler:  { success, recipe in
            XCTAssertNil(recipe)
            XCTAssertFalse(success)
        })
    }

    func testGivenWeNeedARecipeWhenWeMakeAResquestThenWeGetAHTTPError() {
        let fakeResponse = FakeRecipeData().returnResponse(reponseType: ResponseType.badHttpResponse)
        let fakeRequest = FakeRequest(reponse: fakeResponse)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, request: fakeRequest))

        yummlyApi.queryForRecipe(forRecipeID: "id", completionHandler:  { success, recipe in
            XCTAssertNil(recipe)
            XCTAssertFalse(success)
        })
    }

    func testGivenWeNeedARecipeWhenWeMakeAResquestThenWeGetBadData() {
        let fakeResponse = FakeRecipeData().returnResponse(reponseType: ResponseType.badData)
        let fakeRequest = FakeRequest(reponse: fakeResponse)

        let yummlyApi = YummlyAPIService(yummlySession: FakeYummlySession(endPoint: YummlyConstant.endPointForSearch, request: fakeRequest))

        yummlyApi.queryForRecipe(forRecipeID:"id", completionHandler:  { success, recipe in
            XCTAssertNil(recipe)
            XCTAssertFalse(success)
        })
    }
}
