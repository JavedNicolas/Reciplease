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

class FakeYummlySession : YummlySession {

    private var request : FakeRequest

    init(endPoint: String, request : FakeRequest) {
        self.request = request
        super.init(endPoint: endPoint)
    }

    override func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> ()) {
        self.request.responseJSON { (urlRequest, response, data, error) -> Void in
            let result = Request.serializeResponseJSON(options: .allowFragments, response: response, data: data, error: error)
            completionHandler(DataResponse(request: urlRequest, response: response, data: data, result: result))
        }
    }
}

public class FakeRequest{

    var reponse : Reponse

    struct Reponse {
        var response: HTTPURLResponse?
        var data: Data?
        var error: Error?
    }

    init(reponse : Reponse) {
        self.reponse = reponse
    }

    public func responseJSON(completionHandler: (URLRequest, HTTPURLResponse?, Data?, Error?) -> Void) {

        completionHandler(URLRequest(url: URL(string: "url.com")!), reponse.response, reponse.data, reponse.error)
    }
}


