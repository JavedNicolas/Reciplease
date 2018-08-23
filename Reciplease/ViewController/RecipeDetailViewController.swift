//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Nicolas on 03/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData

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
    lazy var favoriteButton = FavoriteButton(image: UIImage(named: "addtofavorite_icon"), style: .plain, target: self, action: #selector(favorite))

    // --------- Action
    /** Open a Safari page with the recipe **/
    @IBAction func getRecipe(_ sender: Any) {
        guard let recipeDetail = recipeDetail, let sources = recipeDetail.source, let source = sources.sourceRecipeUrl,
            let url = URL(string: source) else {
                return
        }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    func setUpNavigationBar() {
        self.navigationItem.title = "Recipe Detail"
        self.navigationItem.rightBarButtonItem = favoriteButton
    }

    /** Handle the image favorite click by changing the image and add or remove the favorite badge **/
    @objc func favorite() {
        favoriteButton.isFavorite = !favoriteButton.isFavorite

        guard let tab = self.tabBarController else {return}
        let item = tab.tabBar.items![0]
        item.badgeColor = UIColor(named: "Red")

        if favoriteButton.isFavorite {
            CoreDataManager.shared.saveFavorite(recipe: recipe)
            item.badgeValue = "New"
        }else {
            CoreDataManager.shared.removeFavorite(recipe: recipe)
            item.badgeValue = nil
        }
    }

    /** Display the recipe infos **/
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

    // ---------- VC function
    override func viewDidLoad() {
        super.viewDidLoad()
        displayRecipe()
        guard let recipe = recipe, let id = recipe.id else {
            return
        }

        setUpNavigationBar()

        if let _ = CoreDataManager.shared.getFavorite(id: id) {
            favoriteButton.isFavorite = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
