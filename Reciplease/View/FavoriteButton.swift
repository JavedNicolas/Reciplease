//
//  FavoriteButton.swift
//  Reciplease
//
//  Created by Nicolas on 09/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    var isFavorite : Bool = false {
        didSet {
            if isFavorite {
                self.setImage(UIImage(named: "unfavorite_icon"), for: .normal) 
            }else {
                self.setImage(UIImage(named: "addtofavorite_icon"), for: .normal)
            }
        }
    }
}
