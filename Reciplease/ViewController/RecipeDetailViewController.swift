//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Nicolas on 03/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    // --------- Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var durantionLabel: UILabel!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!

    // --------- Attribut
    var recipe : Recipe?

    // --------- Action
    @IBAction func getRecipe(_ sender: Any) {

    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    // ---------- VC function
    override func viewDidLoad() {
        super.viewDidLoad()
        displayRecipe()
    }

    func displayRecipe() {
        guard let recipe = recipe, let name = recipe.recipeName,
            let duration = recipe.totalTimeInSeconds,
            let imageUrlString = recipe.imageUrlsBySize else {
                return
        }

        titleLabel.text = name
        durantionLabel.text = String(duration / 60) + " min"
        let rightSizeUrl = String((imageUrlString["90"]?.dropLast(5))!) + "s1200"
        let url = URL(string: rightSizeUrl)
        let data = try? Data(contentsOf: url!)

        if let data = data {
            let image = UIImage(data: data)
            imageView.image = image
        }else {
            imageView.image = #imageLiteral(resourceName: "Recipes-Image")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
