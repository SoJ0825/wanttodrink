import UIKit

class OnlyCoolCell: UITableViewCell {

    @IBOutlet weak var firstButtonOutlet: OrderFormButton!
    
    let setButtonStyle = SetButtonStyle()
    var delegate: OrderFormDelegate?
    
    var canBeCool: Bool = false
    var canBeHot: Bool = true
    
    @IBAction func firstButton(_ sender: Any) {
        if canBeCool {
            delegate?.changeTempCellButton(type: "cool")
        } else if canBeHot {
            delegate?.changeTempCellButton(type: "hot")
        }
    }
    
    func updateUI() {
        if canBeCool {
            firstButtonOutlet.setTitle("冷飲", for: .normal)
            delegate?.changeTempCellButton(type: "cool")
        } else if canBeHot {
            firstButtonOutlet.setTitle("熱飲", for: .normal)
            delegate?.changeTempCellButton(type: "hot")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setButtonStyle.highlightStyle(to: firstButtonOutlet)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
