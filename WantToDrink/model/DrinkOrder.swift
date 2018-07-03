import Foundation

class DrinkOrder {
    var sheetName: String = ""
    var name: String = ""
    var store: String = ""
    //var drinkIndex: String = ""
    var drinkName: String = ""
    var size: String = ""
    var price: String = ""
    var sugar: String = ""
    var ice: String = ""
    var amount: String = ""
    var totalPrice: String = ""
    var note: String = ""
    var orderDate: String = ""
    
    func checkOrder() -> String {
        
        if size == "" {
            return "error: 請選擇飲料尺寸"
        }
        if amount == "" {
            return "error: 請選擇飲料數量"
        }
        if sugar == "" {
            return "error: 請選擇飲料甜度"
        }
        if ice == "" {
            return "error: 請選擇冷飲or熱飲"
        }

        return "data OK"
    }
    
}
