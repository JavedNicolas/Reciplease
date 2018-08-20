//
//  FakeURLSession.swift
//  RecipleaseTests
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation

enum ResponseType {
    case goodResponse
    case error
    case badHttpResponse
    case badData
}

protocol FakeData {

    var reponseOK : HTTPURLResponse? { get }
    var reponseKO : HTTPURLResponse? { get }

    func returnResponse(reponseType: ResponseType) -> FakeRequest.Reponse
}

extension FakeData {
    var reponseOK : HTTPURLResponse? {
        return HTTPURLResponse(url: URL(string: "http://fakeurl.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    }
    var reponseKO : HTTPURLResponse? {
        return HTTPURLResponse(url: URL(string: "http://fakeurl.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
    }
}
