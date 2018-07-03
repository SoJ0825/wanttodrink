import UIKit

class SugarCell: UITableViewCell {

    @IBOutlet weak var normalSugarButton: OrderFormButton!
    @IBOutlet weak var fewSugarButton: OrderFormButton!
    @IBOutlet weak var halfSugarButton: OrderFormButton!
    @IBOutlet weak var alittleSugarButton: OrderFormButton!
    @IBOutlet weak var twoTenthSugarButton: OrderFormButton!
    @IBOutlet weak var oneTenthSugarButton: OrderFormButton!
    @IBOutlet weak var noSugarButton: OrderFormButton!
    
    let setButtonStyle = SetButtonStyle()
    
    var delegate: OrderFormDelegate?
    
    @IBAction func selectSugar(_ sender: OrderFormButton) {
        
        setButtonStyle.defaultStyle(to: normalSugarButton)
        setButtonStyle.defaultStyle(to: fewSugarButton)
        setButtonStyle.defaultStyle(to: halfSugarButton)
        setButtonStyle.defaultStyle(to: alittleSugarButton)
        setButtonStyle.defaultStyle(to: twoTenthSugarButton)
        setButtonStyle.defaultStyle(to: oneTenthSugarButton)
        setButtonStyle.defaultStyle(to: noSugarButton)
        
        setButtonStyle.highlightStyle(to: sender)
        switch sender {
        case normalSugarButton:
            delegate?.record(sugar: "全糖")
        case fewSugarButton:
            delegate?.record(sugar: "少糖")
        case halfSugarButton:
            delegate?.record(sugar: "半糖")
        case alittleSugarButton:
            delegate?.record(sugar: "三分糖")
        case twoTenthSugarButton:
            delegate?.record(sugar: "兩分糖")
        case oneTenthSugarButton:
            delegate?.record(sugar: "一分糖")
        case noSugarButton:
            delegate?.record(sugar: "無糖")
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
