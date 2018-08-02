//
//  YummlySession.swift
//  Reciplease
//
//  Created by Nicolas on 02/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import Foundation

class YummlySession : Yummly {
    // --------------- attribut
    var endPoint: String

    // -------------- init
    init(endPoint : String) {
        self.endPoint = endPoint
    }
}
