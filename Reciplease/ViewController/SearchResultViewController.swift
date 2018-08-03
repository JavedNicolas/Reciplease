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
    var recipes : [Recipe]?

    // --------- Action
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    // --------- VC Function
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultTableView.rowHeight = 130
        searchResultTableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
