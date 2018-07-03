import UIKit

class CoolOrHotCell: UITableViewCell {

    @IBOutlet weak var coolOrHotStackView: UIStackView!
    @IBOutlet weak var coolButtonOutlet: OrderFormButton!
    @IBOutlet weak var hotButtonOutlet: OrderFormButton!
    
    let canBeCool: String = "1"
    let canBeHot: String = "0"
    
    let setButtonStyle = SetButtonStyle()
    
    var delegate: OrderFormDelegate?
    
    @IBAction func coolButton(_ sender: OrderFormButton) {
        
        setButtonStyle.defaultStyle(to: hotButtonOutlet)
        setButtonStyle.highlightStyle(to: coolButtonOutlet)
        
        delegate?.changeTempCellButton(type: "cool")
        
    }
    
    @IBAction func hotButton(_ sender: OrderFormButton) {
        
        setButtonStyle.defaultStyle(to: coolButtonOutlet)
        setButtonStyle.highlightStyle(to: hotButtonOutlet)
        
        delegate?.changeTempCellButton(type: "hot")
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        hotButtonOutlet.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
