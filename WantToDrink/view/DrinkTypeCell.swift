import UIKit

class DrinkTypeCell: UICollectionViewCell {

    @IBOutlet weak var tittleLabel: UILabel!
    
    func update(tittle: String) {
        tittleLabel.text = tittle
    }
    
    func backgroundHighlight(bool: Bool) {
        
        if bool {
            self.backgroundColor = UIColor(red: 0x2b/255, green: 0x42/255, blue: 0x81/255, alpha: 1)
        } else {
            self.backgroundColor = UIColor(red: 0x05/255, green: 0xac/255, blue: 0xd3/255, alpha: 1)
            
        }
        
    }
    
}
