//
//  FakeData.swift
//  RecipleaseTests
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation
import Alamofire

class FakeRecipeSearchData : FakeData {

    class RecipeQueryError : Error {}
    let error = RecipeQueryError()
    
    var correctData : Data {
        let url = Bundle(for: FakeRecipeSearchData.self).url(forResource: "IngredientQueryResult", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    let wrongData = "error".data(using: .utf8)!


    func returnResponse(reponseType: ResponseType) -> FakeRequest.Reponse{
        switch reponseType {
        case .goodResponse:
            return FakeRequest.Reponse(response: reponseOK, data: correctData, error: nil)
        case .error:
            return FakeRequest.Reponse(response: reponseOK, data: correctData, error: error)
        case .badHttpResponse:
            return FakeRequest.Reponse(response: reponseKO, data: correctData, error: nil)
        case .badData:
            return FakeRequest.Reponse(response: reponseOK, data: wrongData, error: nil)
        }
    }
}
