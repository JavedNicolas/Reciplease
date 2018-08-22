//
//  SearchResultViewController.swift
//  Reciplease
//
//  Created by Nicolas on 03/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {

    // --------- Outlet
    @IBOutlet weak var searchResultTableView: UITableView!

    // --------- attribut
    var recipes : [RecipeSummary]?

    // --------- Action
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    // --------- VC Function
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultTableView.reloadData()
        self.navigationItem.title = "Search Result"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
