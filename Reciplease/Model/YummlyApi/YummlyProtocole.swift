//
//  YummlyProtocole.swift
//  Reciplease
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation
import Alamofire

protocol Yummly {
     /** end point for the query**/
    var endPoint : String { get }

    /** contains the url with endpoint, and api keys **/
    var apiUrlString : String { get }

     /** the request to the Api **/
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> ())
}

extension Yummly {
    var apiUrlString : String {
        let string = endPoint + YummlyConstant.appID + YummlyConstant.apiKey
        return string
    }
}

