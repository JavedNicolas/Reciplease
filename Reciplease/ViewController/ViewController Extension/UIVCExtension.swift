//
//  UIVCExtension.swift
//  Reciplease
//
//  Created by Nicolas on 23/08/2018.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     SetUp the label for when the list is empty and display it

     - Parameters:
        - display : Boolean to display of hide the label
        - tableView : The table in which the label will be displayed
        - textToDisplay : The text to display
     */
    func emptyListLabelSetUp(display: Bool, tableView: UITableView, textToDisplay: String) -> UIView {
        if display {
            let tableViewWidth = tableView.bounds.size.width
            let tableViewHeight = tableView.bounds.size.height
            let rect = CGRect(origin: CGPoint(x: 0, y: 0),size: CGSize(width: tableViewWidth,height: tableViewHeight))
            let emptyListLabel = UILabel(frame: rect)

            emptyListLabel.text = textToDisplay
            emptyListLabel.numberOfLines = 0
            emptyListLabel.textAlignment = .center
            emptyListLabel.font = UIFont(name: "Baskerville", size: 20)
            return emptyListLabel
        } else {
            return UIView()
        }
    }
}
