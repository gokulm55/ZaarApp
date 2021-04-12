//
//  ProjectListCell.swift
//  ZaarApp
//
//  Created by apple on 31/03/21.
//

import UIKit

class ProjectListCell: UITableViewCell {

    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var projectDiscription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
