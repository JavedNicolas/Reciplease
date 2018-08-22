//
//  FavoriteButton.swift
//  Reciplease
//
//  Created by Nicolas on 09/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

class FavoriteButton: UIBarButtonItem {
    
     /** display empty or full star to favorite or unfavorite a recipe**/
    var isFavorite : Bool = false {
        didSet {
            if isFavorite {
                self.image = UIImage(named: "unfavorite_icon")
            }else {
                self.image = UIImage(named: "addtofavorite_icon")
            }
        }
    }
}
