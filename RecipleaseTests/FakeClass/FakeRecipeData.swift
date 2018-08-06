//
//  FakeRecipeData.swift
//  RecipleaseTests
//
//  Created by Nicolas on 06/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation

class FakeRecipeData {
    static let reponseOK = HTTPURLResponse(url: URL(string: "http://fakeurl.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let reponseKO = HTTPURLResponse(url: URL(string: "http://fakeurl.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)

    class RecipeQueryError : Error {}
    static let error = RecipeQueryError()

    static var correctData : Data {
        let url = Bundle(for: FakeRecipeSearchData.self).url(forResource: "RecipeQueryResult", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let wrongData = "error".data(using: .utf8)!
}
