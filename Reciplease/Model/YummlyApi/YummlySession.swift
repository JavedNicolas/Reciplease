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
    var endPoint: String

    // -------------- init
    init(endPoint : String) {
        self.endPoint = endPoint
    }

    // ------------ function
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> ()) {
        Alamofire.request(url).responseJSON(queue: nil, options: .allowFragments, completionHandler:
            { (data) in completionHandler(data)})
    }
}
