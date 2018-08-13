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


    // --------- VC function
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        recipeList = Favorite().getAllFavorite
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    internal func removeFavorite(row: Int) {
        guard let recipes = recipeList, let id = recipes[row].id else {
            return
        }

        var favorite : Favorite?
        let request : NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            favorite = try AppDelegate.viewContext.fetch(request).first
        }catch {

        }
        if let favorite = favorite {
            AppDelegate.viewContext.delete(favorite)
            do {
                try AppDelegate.viewContext.save()
            } catch {
                
            }
            recipeList = Favorite().getAllFavorite
            tableView.reloadData()
        }
    }
}

