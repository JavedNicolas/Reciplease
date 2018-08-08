//
//  Rating.swift
//  Reciplease
//
//  Created by Nicolas on 03/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

class Rating: UIStackView {
    @IBOutlet var images : [UIImageView]!

    var rating : Int? = nil {
        didSet {
            for image in images {
                if image.tag > rating! {
                    image.image = UIImage(named: "grey_rating_star")
                }
            }
        }
    }
}
