//
//  AllergiesTableViewCell.swift
//  PersonalizeApp
//
//  Created by Pyae Phyo Oo on 12/11/2023.
//

import Foundation
import UIKit

protocol AllergiesTableViewCellProtocol: AnyObject {
    func toAdd(index: Int, allergies: AllergiesModelData)
}

class AllergiesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    weak var delegate: AllergiesTableViewCellProtocol?
    
    var index: Int?
    var allergies: AllergiesModelData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func didTappedSelect(_ sender: Any) {
        self.delegate?.toAdd(index: index!, allergies: allergies!)
    }
}
