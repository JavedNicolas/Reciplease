//
//  FakeURLSession.swift
//  RecipleaseTests
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation

class FakeUrlSession : URLSession {

    var data : Data?
    var error : Error?
    var response : URLResponse?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.error = error
        self.response = response
    }

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = FakeURLSessionDataTask()
        task.completionHandler = completionHandler
        task.data = data
        task.urlError = error
        task.HTTPResponse = response
        return task
    }

}

class FakeURLSessionDataTask : URLSessionDataTask {

    var completionHandler : ((Data?, URLResponse?, Error?) -> Void?)?

    var data : Data?
    var urlError : Error?
    var HTTPResponse : URLResponse?

    override func resume() {
        completionHandler?(data, HTTPResponse, urlError)
    }

    override func cancel() {}
}

