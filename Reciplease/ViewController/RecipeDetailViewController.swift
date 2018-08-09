//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Nicolas on 03/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeDetailViewController: UIViewController {

    // --------- Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var durantionLabel: UILabel!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingStackView: Rating!

    // --------- Attribut
    var recipe : RecipeSummary?
    var recipeDetail : RecipeDetail?

    // --------- Action
    @IBAction func getRecipe(_ sender: Any) {
        guard let recipeDetail = recipeDetail, let sources = recipeDetail.source, let source = sources.sourceRecipeUrl,
            let url = URL(string: source) else {
                return
        }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
        guard let recipe = recipe, let name = recipe.recipeName, let duration = recipe.totalTimeInSeconds,
            let rating = recipe.rating, let imageUrlString = recipe.imageUrlsBySize else {
                return
        }

        titleLabel.text = name
        durantionLabel.text = String(duration ) + " min"
        let rightSizeUrl = String((imageUrlString["90"]?.dropLast(5))!) + "s1200"
        ratingStackView.rating = rating
        if let url = URL(string: rightSizeUrl) {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "Recipe-Image"),
                                  options: SDWebImageOptions.scaleDownLargeImages, completed: nil)
        }
        ingredientTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
