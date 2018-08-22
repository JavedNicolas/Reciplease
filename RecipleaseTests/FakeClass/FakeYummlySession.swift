//
//  FakeYummlySession.swift
//  RecipleaseTests
//
//  Created by Nicolas on 17/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation
@testable import Reciplease
import Alamofire

// ------ Fake session to avoid doing query for test
class FakeYummlySession : YummlySession {
    // Instance of Fake Response
    private var response : FakeData.Reponse

    // init with an end point and a fakeReesponse
    init(endPoint: String, response : FakeData.Reponse) {
        self.response = response
        super.init(endPoint: endPoint)
    }

    // Override of the query function so we can avoid the query and just return our fake Datas
    override func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> ()) {
        let httpResponse = response.response
        let data = response.data
        let error = response.error

        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data:data, error: error)
        let urlRequest = URLRequest(url: URL(string: self.apiUrlString)!)
        completionHandler(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
}
