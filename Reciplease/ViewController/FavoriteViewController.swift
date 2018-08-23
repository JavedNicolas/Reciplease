//
//  FirstViewController.swift
//  Reciplease
//
//  Created by Nicolas on 01/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    // --------- Outlet
    @IBOutlet weak var tableView: UITableView!

    // --------- Attribut
    internal var recipeList : [RecipeSummary]?
    private var emptyListLabel : UILabel?


    // --------- VC function
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        // Get all Favorite
        recipeList = Favorite().getAllFavorite

        guard let recipeList = recipeList else {
            return
        }

        // Display an explication label when there is no Favorite
        if recipeList.count <= 0 {
            displayEmptyListLabel(display: true)
        }else {
            displayEmptyListLabel(display: false)
        }
        tableView.reloadData()

        // Hide the "New" badge when the viewController is displayed
        guard let tab = self.tabBarController else {return}
        let item = tab.tabBar.items![0]
        item.badgeValue = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ----------- function
    /**
     Display the label for when the list is empty

     - Parameters:
        - display : Boolean to display of hide the label
    */
    func displayEmptyListLabel(display: Bool) {
        let labelText = "You don't have favorite recipes !\n To get favorite do a search and use the green star !"
        let label = emptyListLabelSetUp(display: display, tableView: tableView, textToDisplay: labelText)

        tableView.backgroundView = label
    }
}

