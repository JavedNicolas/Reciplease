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
        guard let recipe = recipe, let name = recipe.recipeName,
            let duration = recipe.totalTimeInSeconds,
            let rating = recipe.rating,
            let imageUrlString = recipe.imageUrlsBySize else {
                return
        }

        titleLabel.text = name
        durantionLabel.text = String(duration ) + " min"
        let rightSizeUrl = String((imageUrlString["90"]?.dropLast(5))!) + "s1200"
        displayCorrectRating(rating)
        let url = URL(string: rightSizeUrl)
        let data = try? Data(contentsOf: url!)

        if let data = data {
            let image = UIImage(data: data)
            imageView.image = image
        }else {
            imageView.image = #imageLiteral(resourceName: "Recipes-Image")
        }
        ingredientTableView.reloadData()
    }

    func displayCorrectRating(_ rating : Int) {
        for image in rating..<5 {
            if let imageView = ratingStackView.arrangedSubviews[image] as? UIImageView {
                imageView.image = UIImage(named: "grey_rating_star")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
