//
//  RepositoryCell.swift
//  RepoSearcher
//
//  Created by Arthur Myronenko on 6/29/17.
//  Copyright © 2017 UPTech Team. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var starsCountLabel: UILabel!
    
    var model: Repository! {
        didSet {
            nameLabel.text = model.fullName
            descriptionLabel.text = model.description
            starsCountLabel.text = "✨" + String(model.starsCount)
        }
    }
    
    var model_mvvm: RepositoryViewModel! {
        didSet {
            nameLabel.text = model_mvvm.name
            descriptionLabel.text = model_mvvm.description
            starsCountLabel.text = model_mvvm.starsCountText
        }
    }
    
}
