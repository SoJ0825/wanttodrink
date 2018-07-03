import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var charactorCount: UILabel!
    
    let maxCharactor: String = "20"
    
    var delegate: OrderFormDelegate?
    
    @IBAction func editingNote(_ sender: UITextField) {
    
        charactorCount.text = "(\(String(describing: noteTextField.text!.count))/\(maxCharactor))"
        
    }
    
    @IBAction func editingNoteDidEnd(_ sender: Any) {
        print("editingEnd： \(noteTextField.text!)")
        if noteTextField.text! != "有特別需求請加入備註" {
            delegate?.record(note: noteTextField.text!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        charactorCount.text = "(\(String(describing: noteTextField.text!.count))/\(maxCharactor))"
        noteTextField.returnKeyType = .done
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
