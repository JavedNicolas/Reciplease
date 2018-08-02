//
//  FakeData.swift
//  RecipleaseTests
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation

class FakeData {
    static let reponseOK = HTTPURLResponse(url: URL(string: "http://fakeurl.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let reponseKO = HTTPURLResponse(url: URL(string: "http://fakeurl.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

    class QueryError : Error {}
    static let error = QueryError()

    static var correctData : Data {
        let url = Bundle(for: FakeData.self).url(forResource: "IngredientQueryResult", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let wrongData = "error".data(using: .utf8)!
}
