import Foundation
import UIKit

class SetButtonStyle {
    
    let grayColor = UIColor(white:0.5, alpha:1)
    let blueColor = UIColor(red: 0x04/255, green: 0x86/255, blue: 0xDB/255, alpha: 1)
    
    func defaultStyle(to button: UIButton) {
        
        UIView.animate(withDuration: 0.4) {
            
            button.backgroundColor = .white
            button.layer.borderWidth = 1.5
            button.layer.borderColor = self.grayColor.cgColor
            //        button.layer.cornerRadius = 5
            button.tintColor = self.grayColor
        }
    }
    
    func highlightStyle(to button: UIButton) {
        
        UIView.animate(withDuration: 0.4) {
            
            button.backgroundColor = self.blueColor
            button.layer.borderWidth = 1
            button.layer.borderColor = self.blueColor.cgColor
            //        button.layer.cornerRadius = 5
            button.tintColor = .white
        }
        
    }
    
}
