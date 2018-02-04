//
//  ReminderCellTableViewCell.swift
//  Reminders
//
//  Created by Robert Wais on 2/2/18.
//  Copyright © 2018 Robert Wais. All rights reserved.
//

import UIKit

class ReminderCellTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var whenLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(name: String, when: String, type: importanceType){
        self.nameLabel.text = name
        self.whenLabel.text = when
        self.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        //change color of cell based on importance
        //self.type.text = type.rawValue
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
