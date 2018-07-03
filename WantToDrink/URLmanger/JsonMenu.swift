import Foundation

class JsonMenu {
    
    static let shared = JsonMenu()
    
    let urlManger = URLmanger()
    
    func getJsonStoreList(completion: @escaping ([String])->Void ) {
        
        let url = URL(string: urlManger.googleSheetFirstString+urlManger.googleSheetKey+"1"+urlManger.googleSheetLastString)
        
        var storeList = [String]()
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            
            guard err == nil else { return }
            
            if let data = data {
                do {
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String:AnyObject]
                    let jsonDictForFeed = jsonDict?["feed"] as! [String: AnyObject]
                    let jsonArray = jsonDictForFeed["entry"] as! [[String: AnyObject]]
                    
                    for storeDict in jsonArray {
                        storeList.append((storeDict["gsx$storename"]!["$t"]! as? String)!)
                    }
                    completion(storeList)
                } catch {
                    print("Error - \(err!)")
                }
            }
            }.resume()
    }
    
    func getJsonStoreIndex(with storeName: String, completion: @escaping (String)->Void ) {
        
        let url = URL(string: urlManger.googleSheetFirstString+urlManger.googleSheetKey+"1"+urlManger.googleSheetLastString)
        
        var storeIndex: String?
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in

            guard err == nil else { return }
            
            if let data = data {
                do {
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String:AnyObject]
                    let jsonDictForFeed = jsonDict?["feed"] as! [String: AnyObject]
                    let jsonArray = jsonDictForFeed["entry"] as! [[String: AnyObject]]
                    
                    for storeDict in jsonArray {
                        if storeDict["gsx$storename"]!["$t"]! as? String == storeName {
                            storeIndex = storeDict["gsx$storeindex"]!["$t"]! as? String
                        }
                    }
                    completion(storeIndex!)
                } catch {
                    print("Error - \(err!)")
                }
            }
            }.resume()
    }
    
    func getJsonMenu(with storeName: String, completion: @escaping ([[String: String]])->Void ){
        
        var returnDict:Dictionary = [String:String]()
        
        var drinkDics = [[String: String]]()
        
        var storeIndex = "1"
        
        getJsonStoreIndex(with: storeName) { (index) in
            storeIndex = index
            
            let url = URL(string: self.urlManger.googleSheetFirstString+self.urlManger.googleSheetKey+storeIndex+self.urlManger.googleSheetLastString)
            
            var urlRequest:URLRequest?
            
            if UserDefaults.standard.bool(forKey: "firstGetJson") == false {
                urlRequest = URLRequest(url: url!, cachePolicy:.reloadIgnoringLocalCacheData, timeoutInterval: 15)
                UserDefaults.standard.set(true, forKey: "firstGetJson")
            } else {
                urlRequest = URLRequest(url: url!, cachePolicy:.returnCacheDataElseLoad, timeoutInterval: 15)
            }
            
            URLSession.shared.dataTask(with: url!) { (data, response, err) in
                
                guard err == nil else {
                    return
                }
                
                if let data = data {
                    do {
                        let jsonDict = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String:AnyObject]
                        let jsonDictForFeed = jsonDict?["feed"] as! [String: AnyObject]
                        let jsonArray = jsonDictForFeed["entry"] as! [[String: AnyObject]]
                        
                        for drinkDict in jsonArray {
                            returnDict["drinkType"] = drinkDict["gsx$drinktype"]!["$t"]! as? String
                            
                            returnDict["drinkName"] = drinkDict["gsx$drinkname"]!["$t"]! as? String
                            
                            returnDict["IsTop"] = drinkDict["gsx$istop"]!["$t"]! as? String
                            
                            returnDict["SPrice"] = drinkDict["gsx$sprice"]!["$t"]! as? String
                            
                            returnDict["MPrice"] = drinkDict["gsx$mprice"]!["$t"]! as? String
                            
                            returnDict["LPrice"] = drinkDict["gsx$lprice"]!["$t"]! as? String
                            
                            returnDict["XLPrice"] = drinkDict["gsx$xlprice"]!["$t"]! as? String
                            
                            returnDict["CanBeCool"] = drinkDict["gsx$canbecool"]!["$t"]! as? String
                            
                            returnDict["CanBeHot"] = drinkDict["gsx$canbehot"]!["$t"]! as? String
                            
                            returnDict["AdjSugar"] = drinkDict["gsx$adjsugar"]!["$t"]! as? String
                            
                            returnDict["AdjIce"] = drinkDict["gsx$adjice"]!["$t"]! as? String
                            
                            returnDict["Note"] = drinkDict["gsx$note"]!["$t"]! as? String
                            
                            drinkDics.append(returnDict)
                        }
                        
                        completion(drinkDics)
                    } catch {
                        print("Error - \(err!)")
                    }
                }
                }.resume()
        }
    }

    func getJsonOrder(completion: @escaping ([[String: String]])->Void) {
        
        var returnDict:Dictionary = [String:String]()
        
        var orderDics = [[String: String]]()
        
        let orderIndex = "2"
            
        let url = URL(string: urlManger.googleSheetFirstString+urlManger.googleSheetKey+orderIndex+urlManger.googleSheetLastString)
        
        var urlRequest:URLRequest?
        
        if UserDefaults.standard.bool(forKey: "firstGetJson") == false {
            urlRequest = URLRequest(url: url!, cachePolicy:.reloadIgnoringLocalCacheData, timeoutInterval: 15)
            UserDefaults.standard.set(true, forKey: "firstGetJson")
        } else {
            urlRequest = URLRequest(url: url!, cachePolicy:.returnCacheDataElseLoad, timeoutInterval: 15)
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            
            guard err == nil else {
                return
            }
            
            if let data = data {
                do {
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String:AnyObject]
                    let jsonDictForFeed = jsonDict?["feed"] as! [String: AnyObject]
                    let jsonArray = jsonDictForFeed["entry"] as! [[String: AnyObject]]
                    
                    for jsonData in jsonArray {
                        
                        let titleString = jsonData["title"]!["$t"]! as! String
                        let contentString = jsonData["content"]!["$t"]! as! String
                        let contentArray = contentString.components(separatedBy: ", ")
                        
                        returnDict["name"] = titleString
                        
                        for str in contentArray {
                            let colon = str.index(of: ":")
                            let fromIndex = str.index(colon!, offsetBy: 2)
                            
                            let key = str.substring(to: colon!)
                            let value = str.substring(from: fromIndex)
                            
                            returnDict[key] = value
                            
                        }
                        orderDics.append(returnDict)
                    }
                    
                    completion(orderDics)
                } catch {
                    print("Error - \(err!)")
                }
            }
            }.resume()
}
        
    }

//struct jsonData: Codable {
//    
//    var drinkType : detailData?
//    
//    struct detailData: Codable {
//        var value : String?
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case drinkType = "gsx$drinktype"
//        case value = "$t"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let valuContainer = try decoder.container(keyedBy: CodingKeys.self)
//        self.drinkType = try valuContainer.decodeIfPresent(String.self, forKey: CodingKeys.drinkType)
//    }
//    
//}
