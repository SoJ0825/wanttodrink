import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var sugar: UILabel!
    @IBOutlet weak var ice: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var note: UILabel!
    
    func updateUI(drink: [String:String]) {
        drinkName.text = drink["drinkname"]
        size.text = drink["size"]
        price.text = "單價：$" + drink["price"]!
        sugar.text = drink["sugar"]
        sugar.layer.cornerRadius = 15
//        sugar.layer.masksToBounds = true
        ice.text = drink["ice"]
        ice.layer.cornerRadius = 15
//        ice.layer.masksToBounds = true
        amount.text = drink["amount"]! + " 杯"
        amount.layer.cornerRadius = 15
//        amount.layer.masksToBounds = true
        totalPrice.text = "$ \(Int(drink["price"]!)! * Int(drink["amount"]!)!)"
        
//        totalPrice.layer.masksToBounds = true
        
        note.text = drink["note"]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
totalPrice.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
