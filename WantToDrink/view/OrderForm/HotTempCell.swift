import UIKit

class HotTempCell: UITableViewCell {

    @IBOutlet weak var homoeothermyButton: OrderFormButton!
    @IBOutlet weak var hotterButton: OrderFormButton!
    
    let setButtonStyle = SetButtonStyle()
    
    var delegate: OrderFormDelegate?
    
    @IBAction func selectTemp(_ sender: OrderFormButton) {
        
        setButtonStyle.defaultStyle(to: homoeothermyButton)
        setButtonStyle.defaultStyle(to: hotterButton)
        
        switch sender {
        case homoeothermyButton:
            setButtonStyle.highlightStyle(to: homoeothermyButton)
            delegate?.record(ice: "常溫")
        case hotterButton:
            setButtonStyle.highlightStyle(to: hotterButton)
            delegate?.record(ice: "熱一點")
        default:
            return
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
