//
//  TableViewCell.swift
//  Lab_6
//
//  Created by user237779 on 2/19/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titlelable: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
