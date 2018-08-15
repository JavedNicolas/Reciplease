//
//  ErrorProtocole.swift
//  Reciplease
//
//  Created by Nicolas on 15/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

protocol ErrorProtocole : Error {}

enum ErrorList : String, ErrorProtocole {
    case unknowError = "An unknown error as occured. \nPlease try again later."
    case noResult = "No Result was found. \nTry to change your ingredients, or check your connection."
}

protocol ErrorDelegate {
    func errorHandling(error: ErrorProtocole)
}

extension UIViewController : ErrorDelegate {
    func errorHandling(error: ErrorProtocole) {
        let alert = createAlertController(error: error)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)
    }

    func createAlertController(error: ErrorProtocole) -> UIAlertController{
        guard let error = error as? ErrorList else {
            print("error casting error")
            return UIAlertController()
        }

        let alert = UIAlertController(title: "An Error as Occured", message: error.rawValue, preferredStyle: .alert)
        return alert
    }
}
