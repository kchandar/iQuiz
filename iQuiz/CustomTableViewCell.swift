//
//  CustomTableViewCell.swift
//  iQuiz
//
//  Created by Keertana Chandar on 2/11/18.
//  Copyright © 2018 Keertana Chandar. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBOutlet weak var cellView: UIView!
    
    
    
    @IBOutlet weak var quizImage: UIImageView!
    
    
    @IBOutlet weak var quizLabel: UILabel!
    
    
    @IBOutlet weak var quizDescriptionLabel: UILabel!
    
    
    
    
}
