import UIKit

class CoolTempCell: UITableViewCell {

    @IBOutlet weak var normalIceButton: OrderFormButton!
    @IBOutlet weak var fewIceButton: OrderFormButton!
    @IBOutlet weak var alittleIceButton: OrderFormButton!
    @IBOutlet weak var noIceButton: OrderFormButton!
    
    let setButtonStyle = SetButtonStyle()
    
    var delegate: OrderFormDelegate?
    
    @IBAction func selectIce(_ sender: OrderFormButton) {
        
        setButtonStyle.defaultStyle(to: normalIceButton)
        setButtonStyle.defaultStyle(to: fewIceButton)
        setButtonStyle.defaultStyle(to: alittleIceButton)
        setButtonStyle.defaultStyle(to: noIceButton)
        
        switch sender {
        case normalIceButton:
            setButtonStyle.highlightStyle(to: normalIceButton)
            delegate?.record(ice: "正常冰")
        case fewIceButton:
            setButtonStyle.highlightStyle(to: fewIceButton)
            delegate?.record(ice: "少冰")
        case alittleIceButton:
            setButtonStyle.highlightStyle(to: alittleIceButton)
            delegate?.record(ice: "微冰")
        case noIceButton:
            setButtonStyle.highlightStyle(to: noIceButton)
            delegate?.record(ice: "去冰")
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
