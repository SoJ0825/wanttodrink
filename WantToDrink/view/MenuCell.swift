import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkTitleLabel: UILabel!
    @IBOutlet weak var CanBeCoolImageView: UIImageView!
    @IBOutlet weak var CanBeHotImageView: UIImageView!
    
    @IBOutlet weak var noteAndPriceStackView: UIStackView!
    @IBOutlet weak var priceStackView: UIStackView!
    @IBOutlet weak var priceStackViewConstraints: NSLayoutConstraint!
    
    func createNewPrice(drink: [String:String]) {
        
        var stackViewWidth:CGFloat = 0
        priceStackViewConstraints.constant = stackViewWidth
        
        let drinkImage = UIImage(named: drink["drinkName"]!)
        drinkImageView.image = drinkImage != nil ? drinkImage : #imageLiteral(resourceName: "defaultDrink")
        drinkTitleLabel.text = drink["drinkName"]
        
        for subview in priceStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
        
        if drink["SPrice"] != "0" {
            let newImageView = UIImageView()
            let newLabel = UILabel()
            newImageView.image = UIImage(named: "blue-S")
            newImageView.contentMode = .scaleAspectFit
            newLabel.text = drink["SPrice"]
            stackViewWidth += 50
            priceStackViewConstraints.constant = stackViewWidth
            priceStackView.addArrangedSubview(newImageView)
            priceStackView.addArrangedSubview(newLabel)
        }
        
        if drink["MPrice"] != "0" {
            let newImageView = UIImageView()
            let newLabel = UILabel()
            newImageView.image = UIImage(named: "blue-M")
            newImageView.contentMode = .scaleAspectFit
            newImageView.contentMode = .scaleAspectFit
            newLabel.text = drink["MPrice"]
            stackViewWidth += 50
            priceStackViewConstraints.constant = stackViewWidth
            priceStackView.addArrangedSubview(newImageView)
            priceStackView.addArrangedSubview(newLabel)
        }
        
        if drink["LPrice"] != "0" {
            let newImageView = UIImageView()
            let newLabel = UILabel()
            newImageView.contentMode = .scaleAspectFit
            newImageView.image = UIImage(named: "blue-L")
            newLabel.text = drink["LPrice"]
            stackViewWidth += 50
            priceStackViewConstraints.constant = stackViewWidth
            priceStackView.addArrangedSubview(newImageView)
            priceStackView.addArrangedSubview(newLabel)
        }
        
        if drink["XLPrice"] != "0" {
            let newImageView = UIImageView()
            let newLabel = UILabel()
            newImageView.contentMode = .scaleAspectFit
            newImageView.image = UIImage(named: "blue-XL")
            newLabel.text = drink["XLPrice"]
            stackViewWidth += 50
//            priceStackView.widthAnchor.constraint(equalToConstant: stackViewWidth).isActive = true
            priceStackViewConstraints.constant = stackViewWidth
            priceStackView.addArrangedSubview(newImageView)
            priceStackView.addArrangedSubview(newLabel)
        }
        
        if drink["CanBeHot"] == "1" {
            CanBeHotImageView.image = #imageLiteral(resourceName: "hot")
        } else {
            CanBeHotImageView.image = nil
        }
        
        if drink["CanBeCool"] == "1" {
            CanBeCoolImageView.image = #imageLiteral(resourceName: "cool")
        }  else {
            CanBeCoolImageView.image = nil
        }
        
        if drink["Note"] != "" {
            let noteStackView = UIStackView()
            let noteImageView = UIImageView()
            let noteLabel = UILabel()
            
            noteStackView.alignment = .center
            noteStackView.distribution = .fillProportionally
            noteStackView.axis = .horizontal
            
            noteImageView.image = UIImage(named: "comments")
            noteLabel.text = drink["Note"]
            
            noteStackView.addArrangedSubview(noteImageView)
            noteStackView.addArrangedSubview(noteLabel)
            
            let font = UIFont.systemFont(ofSize: 17)
            stackViewWidth = NSString(string: noteLabel.text!).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 17), options: .usesLineFragmentOrigin, attributes:[kCTFontAttributeName as NSAttributedStringKey: font] , context: nil).width
            priceStackViewConstraints.constant = stackViewWidth
            noteAndPriceStackView.addArrangedSubview(noteStackView)
//            noteAndPriceStackView.addArrangedSubview(noteLabel)
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
