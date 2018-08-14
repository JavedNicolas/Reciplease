//
//  LoadingView.swift
//  Reciplease
//
//  Created by Nicolas on 13/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

class LoadingView : UIView {

    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!

    var getLoadingView : UIView {
        get {
            return retrivedViewFromXIB()
        }
    }

    func retrivedViewFromXIB() -> UIView {
        let view = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)?.first as? UIView
        guard let loadingView = view else {
            return UIView()
        }
        activityIndicator.startAnimating()

        return loadingView
    }
}
