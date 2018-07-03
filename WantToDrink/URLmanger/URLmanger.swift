import Foundation

struct URLmanger {
    
    //google sheet json
    let googleSheetKey = "1dF8L8fw5mzuRz9C65CYEt4K7QvANJpk_5DCCtrOJid4" + "/"
    
    let googleSheetFirstString = "https://spreadsheets.google.com/feeds/list/"
    
    let googleSheetLastString = "/public/values?alt=json"
    
    let storeListUrl = "https://spreadsheets.google.com/feeds/list/1dF8L8fw5mzuRz9C65CYEt4K7QvANJpk_5DCCtrOJid4/1/public/values?alt=json"
    
    // 新增Google App Script的網址
    let scriptUrl = "https://script.google.com/macros/s/AKfycbwGlknsHjp-JSuX-zNl3vamSghhWqklJI-4BJBwjA/exec"
    
    func getUrlWithParams(drinkOrder: DrinkOrder) -> String {
        
//        let urlWithParams = scriptUrl +
//        """
//        ?sheetName=\(drinkOrder.sheetName)
//        &name=\(drinkOrder.name)
//        &store=\(drinkOrder.store)
//        &drinkName=\(drinkOrder.drinkName)
//        &size=\(drinkOrder.size)
//        &price=\(drinkOrder.price)
//        &sugar=\(drinkOrder.sugar)
//        &ice=\(drinkOrder.ice)
//        &amount=\(drinkOrder.amount)
//        &note=\(drinkOrder.note)
//        &orderDate=\(drinkOrder.orderDate)
//        &type=get
//        """
        let urlWithParams = scriptUrl + "?sheetName=\(drinkOrder.sheetName)&name=\(drinkOrder.name)&store=\(drinkOrder.store)&drinkName=\(drinkOrder.drinkName)&size=\(drinkOrder.size)&price=\(drinkOrder.price)&sugar=\(drinkOrder.sugar)&ice=\(drinkOrder.ice)&amount=\(drinkOrder.amount)&totalPrice=\(drinkOrder.totalPrice)&note=\(drinkOrder.note)&orderDate=\(drinkOrder.orderDate)&type=get"
        return urlWithParams
    }
    
}
