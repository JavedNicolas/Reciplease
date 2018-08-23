//
//  ErrorProtocole.swift
//  Reciplease
//
//  Created by Nicolas on 15/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

/** Error enum **/
enum ErrorList : String, Error {
    case unknowError = "An unknown error as occured. \nPlease try again later."
    case noResult = "No Result was found. \nTry to change your ingredients, or check your connection."
}

/** Error protocole to handle error**/
protocol ErrorDelegate {
    func errorHandling(error: Error)
}

/** Extension of the uiviencontroller to throw error to the user **/
extension UIViewController : ErrorDelegate {
    /** throw and error to the user
     -Parameters:
     - error: Error of ErrorList type.
     */
    func errorHandling(error: Error) {
        let alert = createAlertController(error: error)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)
    }

    /** Create the Alert controller **/
    func createAlertController(error: Error) -> UIAlertController{
        guard let error = error as? ErrorList else {
            print("error casting error")
            return UIAlertController()
        }

        let alert = UIAlertController(title: "An Error as Occured", message: error.rawValue, preferredStyle: .alert)
        return alert
    }
}
