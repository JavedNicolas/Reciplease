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
        recipeList = Favorite().getAllFavorite
        guard let recipeList = recipeList else {
            return
        }

        if recipeList.count <= 0 {
            emptyListLabelSetUp(display: true)
        }else {
            emptyListLabelSetUp(display: false)
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ----------- function
    func emptyListLabelSetUp(display: Bool) {
        if display {
            let tableViewWidth = self.tableView.bounds.size.width
            let tableViewHeight = self.tableView.bounds.size.height
            let rect = CGRect(origin: CGPoint(x: 0, y: 0),size: CGSize(width: tableViewWidth,height: tableViewHeight))
            emptyListLabel = UILabel(frame: rect)
            guard let emptyLabel = emptyListLabel else {
                return
            }

            emptyLabel.text = "You don't have favorite recipes !\n To get favorite do a search and use the green star !"
            emptyLabel.numberOfLines = 0
            emptyLabel.textAlignment = .center
            emptyLabel.font = UIFont(name: "Baskerville", size: 20)
            tableView.backgroundView = emptyLabel
        } else {
            tableView.backgroundView = UIView()
        }
    }
}

