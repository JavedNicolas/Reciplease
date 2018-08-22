//
//  YummlySession.swift
//  Reciplease
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation
import Alamofire

class YummlySession : Yummly {

    // --------------- attribut
     /** end point for the query **/
    var endPoint: String

    // -------------- init
    init(endPoint : String) {
        self.endPoint = endPoint
    }

    // ------------ function
    /**
     Query to the api
     - Parameters:
        - url: The complete Url for the query
        - completionHandler: The data after the end of the query
     */
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> ()) {
        Alamofire.request(url).responseJSON(queue: nil, options: .allowFragments, completionHandler:
            { (data) in completionHandler(data)})
    }
}
