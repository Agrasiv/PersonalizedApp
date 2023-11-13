//
//  HealthConcernsTableViewCell.swift
//  PersonalizeApp
//
//  Created by Pyae Phyo Oo on 12/11/2023.
//

import Foundation
import UIKit

class HealthConcernsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wholeBgView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        wholeBgView.layer.borderWidth = 1
        wholeBgView.layer.borderColor = UIColor.gray.cgColor
        nameLabel.textColor = UIColor.white
        bgView.layer.cornerRadius = 15
        bgView.layer.backgroundColor = UIColor.primaryColor.cgColor
        heightConstraint.constant = UIScreen.main.bounds.height * 0.07
    }
}
