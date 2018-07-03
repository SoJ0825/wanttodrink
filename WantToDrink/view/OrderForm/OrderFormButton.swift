import UIKit

//@IBDesignable
class OrderFormButton: UIButton {
    let grayColor = UIColor(white:0.5, alpha:1)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = grayColor.cgColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = UIColor.white
        self.tintColor = grayColor
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }
}

