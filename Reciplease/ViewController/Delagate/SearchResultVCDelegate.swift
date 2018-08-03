//
//  SearchResultVCDelegate.swift
//  Reciplease
//
//  Created by Nicolas on 03/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

extension SearchResultViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "detail") as? RecipeDetailViewController

        guard let nextVC = nextViewController, let recipe = recipes else {
            return indexPath
        }

        nextVC.recipe = recipe[indexPath.row]
        self.present(nextVC, animated: true, completion: nil)

        return indexPath
    }
}
