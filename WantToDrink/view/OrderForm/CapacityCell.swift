//
//  CapacityCell.swift
//  WantToDrink
//
//  Created by 高菘駿 on 2018/5/29.
//  Copyright © 2018年 SoJ. All rights reserved.
//

import UIKit

class CapacityCell: UITableViewCell {

    @IBOutlet weak var capacityStackView: UIStackView!
    
    var drinkSize = [String]()
    var price = [String:String]()
    var sizeButtons = [UIButton]()
    
    var delegate: OrderFormDelegate?
    
    func createNewCapacity(size: String, imageName: String) {
        
        let newStackView = UIStackView()
        newStackView.axis = .vertical
        newStackView.alignment = .fill
        newStackView.distribution = .fill
        
        let newImageView = UIImageView()
        newImageView.image = UIImage(named: imageName)
        newImageView.contentMode = .scaleAspectFit
        
        let newLabel = UILabel()
        newLabel.text = price[size]
        newLabel.textAlignment = .center
        
        let newButton = UIButton()
        //newButton.isEnabled = true
        newButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        sizeButtons.append(newButton)
        newButton.addTarget(self, action: #selector(selectSize), for: .touchUpInside)
        
        newStackView.addArrangedSubview(newImageView)
        newStackView.addArrangedSubview(newLabel)
        newStackView.addArrangedSubview(newButton)
        
        capacityStackView.addArrangedSubview(newStackView)
        capacityStackView.spacing = 20
    }
    
    @objc func selectSize(sender: UIButton) {
        for button in sizeButtons {
            button.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
        sender.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
        
        let index = sizeButtons.index(of: sender)
        delegate?.record(capacity: drinkSize[index!])
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
