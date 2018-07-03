import UIKit

class AmountCell: UITableViewCell{
    
    @IBOutlet weak var oneCupButton: OrderFormButton!
    @IBOutlet weak var twoCupButton: OrderFormButton!
    @IBOutlet weak var threeCupButton: OrderFormButton!
    @IBOutlet weak var fourCupButton: OrderFormButton!
    @IBOutlet weak var fiveCupButton: OrderFormButton!
    
    @IBOutlet weak var customerAmount: UITextField!
    
    let setButtonStyle = SetButtonStyle()
    
    var delegate: OrderFormDelegate?
    
    @IBAction func selectAmount(_ sender: OrderFormButton) {

        setButtonStyle.defaultStyle(to: oneCupButton)
        setButtonStyle.defaultStyle(to: twoCupButton)
        setButtonStyle.defaultStyle(to: threeCupButton)
        setButtonStyle.defaultStyle(to: fourCupButton)
        setButtonStyle.defaultStyle(to: fiveCupButton)
        
        updateTextFieldStyle(isHighLight: false)
        customerAmount.text = ""

        switch sender {
        case oneCupButton:
            setButtonStyle.highlightStyle(to: oneCupButton)
            delegate?.record(amount: "1")
        case twoCupButton:
            setButtonStyle.highlightStyle(to: twoCupButton)
            delegate?.record(amount: "2")
        case threeCupButton:
            setButtonStyle.highlightStyle(to: threeCupButton)
            delegate?.record(amount: "3")
        case fourCupButton:
            setButtonStyle.highlightStyle(to: fourCupButton)
            delegate?.record(amount: "4")
        case fiveCupButton:
            setButtonStyle.highlightStyle(to: fiveCupButton)
            delegate?.record(amount: "5")
        default:
            return
        }
        
    }
    
    func checkCustomerAmount() {
        
        if let amount = Int(customerAmount.text!) {
            switch amount {
            case 0:
                delegate?.showAlert(message: "數量不可為零")
                customerAmount.text = ""
                updateTextFieldStyle(isHighLight: false)
            case 1:
                setButtonStyle.highlightStyle(to: oneCupButton)
                
                setButtonStyle.defaultStyle(to: twoCupButton)
                setButtonStyle.defaultStyle(to: threeCupButton)
                setButtonStyle.defaultStyle(to: fourCupButton)
                setButtonStyle.defaultStyle(to: fiveCupButton)
                
                updateTextFieldStyle(isHighLight: false)

                customerAmount.text = ""
                delegate?.record(amount: "1")
            case 2:
                setButtonStyle.highlightStyle(to: twoCupButton)
                
                setButtonStyle.defaultStyle(to: oneCupButton)
                setButtonStyle.defaultStyle(to: threeCupButton)
                setButtonStyle.defaultStyle(to: fourCupButton)
                setButtonStyle.defaultStyle(to: fiveCupButton)
                
                updateTextFieldStyle(isHighLight: false)

                customerAmount.text = ""
                delegate?.record(amount: "2")
            case 3:
                setButtonStyle.highlightStyle(to: threeCupButton)
                
                setButtonStyle.defaultStyle(to: oneCupButton)
                setButtonStyle.defaultStyle(to: twoCupButton)
                setButtonStyle.defaultStyle(to: fourCupButton)
                setButtonStyle.defaultStyle(to: fiveCupButton)
                
                updateTextFieldStyle(isHighLight: false)

                customerAmount.text = ""
                delegate?.record(amount: "3")
            case 4:
                setButtonStyle.highlightStyle(to: fourCupButton)
                
                setButtonStyle.defaultStyle(to: oneCupButton)
                setButtonStyle.defaultStyle(to: twoCupButton)
                setButtonStyle.defaultStyle(to: threeCupButton)
                setButtonStyle.defaultStyle(to: fiveCupButton)
                
                updateTextFieldStyle(isHighLight: false)

                customerAmount.text = ""
                delegate?.record(amount: "4")
            case 5:
                setButtonStyle.highlightStyle(to: fiveCupButton)
                
                setButtonStyle.defaultStyle(to: oneCupButton)
                setButtonStyle.defaultStyle(to: twoCupButton)
                setButtonStyle.defaultStyle(to: threeCupButton)
                setButtonStyle.defaultStyle(to: fourCupButton)
                
                updateTextFieldStyle(isHighLight: false)

                customerAmount.text = ""
                delegate?.record(amount: "5")
            case let amount where amount > 9:
                delegate?.showAlert(message: "訂太多杯了")
                updateTextFieldStyle(isHighLight: false)
                customerAmount.text = ""
            default:
                setButtonStyle.defaultStyle(to: oneCupButton)
                setButtonStyle.defaultStyle(to: twoCupButton)
                setButtonStyle.defaultStyle(to: threeCupButton)
                setButtonStyle.defaultStyle(to: fourCupButton)
                setButtonStyle.defaultStyle(to: fiveCupButton)

                
                updateTextFieldStyle(isHighLight: true)
                delegate?.record(amount: String(describing: customerAmount.text))
            }
        }
    }
    
    func updateTextFieldStyle(isHighLight: Bool) {
        
        if isHighLight {
            UIView.animate(withDuration: 0.4) {
                let blueColor = UIColor(red: 0x04/255, green: 0x86/255, blue: 0xDB/255, alpha: 1)
                self.customerAmount.backgroundColor = blueColor
                self.customerAmount.layer.cornerRadius = 5
                self.customerAmount.layer.borderWidth = 1
                self.customerAmount.layer.borderColor = blueColor.cgColor
                self.customerAmount.textColor = .white
            }
            
        } else {
            UIView.animate(withDuration: 0.4) {
                let grayColor = UIColor(white:0.5, alpha:1)
                self.customerAmount.backgroundColor = .white
                self.customerAmount.layer.cornerRadius = 5
                self.customerAmount.layer.borderWidth = 1.5
                self.customerAmount.layer.borderColor = grayColor.cgColor
                self.customerAmount.textColor = grayColor
            }
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        updateTextFieldStyle(isHighLight: false)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
