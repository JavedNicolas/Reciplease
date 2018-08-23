//
//  SearchViewDelegate.swift
//  Reciplease
//
//  Created by Nicolas on 09/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

extension SearchViewController : UITextFieldDelegate {
    /** Add ingredient when the user press continue and hide the keyboard **/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.returnKeyType {
        case .continue:
            textField.resignFirstResponder()
            add(self)
            return true
        default:
            return false
        }
    }
}

extension SearchViewController : UITableViewDelegate {
    /** Allow user to remove ingredient individualy from the list **/
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            ingredient.ingredientList.remove(at: indexPath.row)
        default:
            return
        }
    }
}
