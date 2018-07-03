import Foundation

protocol OrderFormDelegate {
    func changeTempCellButton(type: String)
    func showAlert(message: String)
    func record(capacity: String)
    func record(amount: String)
    func record(sugar: String)
    func record(ice: String)
    func record(note: String)
}

