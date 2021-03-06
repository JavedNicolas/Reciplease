//
//  RecipeCellTableViewCell.swift
//  Reciplease
//
//  Created by Nicolas on 08/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeCell: UITableViewCell {

    // --------- Outlet
    @IBOutlet weak var title : UILabel?
    @IBOutlet weak var ingredients : UILabel?
    @IBOutlet weak var rating : UILabel?
    @IBOutlet weak var duration : UILabel?
    @IBOutlet weak var recipeImage : UIImageView?
    @IBOutlet weak var loadingView : UIView?
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView?

    // -------- Attribut
    /** allow to create the cell with a recipe Struct **/
    var recipe : RecipeSummary? = nil{
        didSet{
            if let recipe = recipe {
                setCell(recipe)
            }
        }
    }

     /** ldisply of hide loading on the cell**/
    func loading(isloading: Bool) {
        guard let loadingView = loadingView, let activityIndicator = activityIndicator else {
            return
        }

        loadingView.isHidden = !isloading
        if isloading {
            activityIndicator.startAnimating()
        }else {
            activityIndicator.stopAnimating()
        }
    }

    // ---------- function
     /** Set value in every outlet of the cell **/
    private func setCell(_ recipe : RecipeSummary) {
        guard let name = recipe.recipeName, let ingredients = recipe.ingredients?.joined(separator: ","),
            let duration = recipe.totalTimeInSeconds, let rating =  recipe.rating,
            let imageUrlString = recipe.imageUrlsBySize else {
                return
        }

        title?.text = name
        self.ingredients?.text = ingredients
        self.duration?.text = String(duration / 60) + " min"
        self.rating?.text = String(rating)
        let rightSizeUrl = String((imageUrlString["90"]?.dropLast(5))!) + "s1200"

        if let url = URL(string: rightSizeUrl) {
            recipeImage?.sd_setImage(with: url, placeholderImage: UIImage(named: "Recipe-Image"), options: SDWebImageOptions.scaleDownLargeImages, completed: nil)
        }
    }

    // ------------ Cell functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
