import UIKit

class OrderFormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, OrderFormDelegate, UITextFieldDelegate {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var orderFirmTableView: UITableView!
    @IBOutlet weak var VCTitle: UILabel!
    @IBOutlet weak var keyboardTool: UIToolbar!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    var keyBoardNeedLayout = true
    
    var didShowCapacityButton = false
    var didSelectCoolButton = false
    var didSelectHotButton = false
    var didShowTempCellButton = false
    
    var drink = [String: String]()
//    var order = [String: String]()
    
    var drinkOrder = DrinkOrder()
    
    @IBAction func cancelOrder(_ sender: UIButton) {
    
    dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func confirmOrder(_ sender: UIButton) {
        
        loadingView.isHidden = false
        loadingLabel.isHidden = false
        
        drinkOrder.sheetName = "訂單"
        drinkOrder.name = "Kao"
        
        let todayDate: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd"
        drinkOrder.orderDate = dateFormatter.string(from: todayDate)
        
        switch drinkOrder.checkOrder() {
        case let str where str.contains("error:"):
            loadingView.isHidden = true
            loadingLabel.isHidden = true
            let alertMessage = String(str.dropFirst(7))
            let alert = UIAlertController(title: "訂單資料沒有填齊全", message: alertMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        default:
            self.view.endEditing(true)
            drinkOrder.totalPrice = "\(Int(drinkOrder.price)! * Int(drinkOrder.amount)!)"
            
            let urlManager = URLmanger()
            let urlWithParams = urlManager.getUrlWithParams(drinkOrder: self.drinkOrder)
            print(urlWithParams)
            let url = URL(string: urlWithParams.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
            //print(url)
            
            var urlRequest = URLRequest(url:url)
            
            // Set request HTTP method to GET. It could be POST as well
            urlRequest.httpMethod = "GET"
            
            // Excute HTTP Request
            let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) {
                data, response, error in
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("responseString = \(responseString!)")
                
                // Check for error
                if error != nil {
                    print("error=\(error!)")
                    let alertController = UIAlertController(title: "系統異常", message: "請再試一次", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "確認", style: UIAlertActionStyle.default, handler: { (action) -> Void in
                        self.loadingView.isHidden = true
                        self.loadingLabel.isHidden = true
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "訂單資料已送出", message: "謝謝您的訂購", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "確認", style: UIAlertActionStyle.default, handler: { (action) -> Void in
                        self.dismiss(animated: true, completion: nil)
                        self.loadingView.isHidden = true
                        self.loadingLabel.isHidden = true
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            task.resume()
        }
        
        
        
    }
    
    @IBAction func confirmAmount(_ sender: UIBarButtonItem) {
        
        orderFirmTableView.reloadData()
        
        //鍵盤漸進消失的時間
        UIView.animate(withDuration: 0.8) {
            self.view.endEditing(true)
        }
    
    }
    
    func changeTempCellButton(type: String) {

        switch type {
        case "cool":
            didSelectCoolButton = true
            didSelectHotButton = false
            didShowTempCellButton = true
        case "hot":
            didSelectCoolButton = false
            didSelectHotButton = true
            didShowTempCellButton = true
        default:
            break
        }
        orderFirmTableView.reloadData()
    }
    
    func record(capacity: String) {
        drinkOrder.size = capacity
        drinkOrder.price = drink["\(capacity)Price"]!
    }
    
    func record(amount: String) {
        drinkOrder.amount = amount
    }
    
    func record(sugar: String) {
        drinkOrder.sugar = sugar
    }
    
    func record(ice: String) {
        drinkOrder.ice = ice
    }
    
    func record(note: String) {
        print(note)
        drinkOrder.note = note
    }

    func showAlert(message: String) {
        
        let alert = UIAlertController(title: "訂單有點問題！", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // do somthing
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if drink["CanBeCool"] == "1" && drink["CanBeHot"] == "1" {
                let coolOrHotCell = tableView.dequeueReusableCell(withIdentifier: "coolOrHotCell", for: indexPath) as! CoolOrHotCell
                coolOrHotCell.delegate = self
                return coolOrHotCell
            }
            
            if drink["CanBeCool"]! == "1" {
                let onlyCoolCell = tableView.dequeueReusableCell(withIdentifier: "onlyCoolCell", for: indexPath) as! OnlyCoolCell
                onlyCoolCell.canBeCool = true
                onlyCoolCell.canBeHot = false
                onlyCoolCell.delegate = self
                if !didShowTempCellButton {
                    onlyCoolCell.updateUI()
                }
                return onlyCoolCell
            } else {
                let onlyHotCell = tableView.dequeueReusableCell(withIdentifier: "onlyCoolCell", for: indexPath) as! OnlyCoolCell
                onlyHotCell.canBeCool = false
                onlyHotCell.canBeHot = true
                onlyHotCell.delegate = self
                if !didShowTempCellButton {
                    onlyHotCell.updateUI()
                }
                return onlyHotCell
            }
            
        case 1:
            let capacityCell = tableView.dequeueReusableCell(withIdentifier: "capacityCell", for: indexPath) as! CapacityCell
            capacityCell.delegate = self
            if !didShowCapacityButton {
                if drink["SPrice"] != "0" {
                    capacityCell.drinkSize.append("S")
                    capacityCell.price["S"] = drink["SPrice"]
                }
                if drink["MPrice"] != "0" {
                    capacityCell.drinkSize.append("M")
                    capacityCell.price["M"] = drink["MPrice"]
                }
                if drink["LPrice"] != "0" {
                    capacityCell.drinkSize.append("L")
                    capacityCell.price["L"] = drink["LPrice"]
                }
                if drink["XLPrice"] != "0" {
                    capacityCell.drinkSize.append("XL")
                    capacityCell.price["XL"] = drink["XLPrice"]
                }
                for sizeString in capacityCell.drinkSize {
                    capacityCell.createNewCapacity(size: sizeString, imageName: "Size" + sizeString)
                }
                if capacityCell.drinkSize.count == 1 {
                    capacityCell.selectSize(sender: capacityCell.sizeButtons[0])
                }
                didShowCapacityButton = !didShowCapacityButton
            }
            return capacityCell
            
        case 2:
            let amountCell = tableView.dequeueReusableCell(withIdentifier: "amountCell", for: indexPath) as! AmountCell
            amountCell.delegate = self
            amountCell.customerAmount.inputAccessoryView = keyboardTool
            amountCell.checkCustomerAmount()
            return amountCell
            
        case 3:
            let sugarCell = tableView.dequeueReusableCell(withIdentifier: "sugarCell", for: indexPath) as! SugarCell
            sugarCell.delegate = self
            return sugarCell
            
        case 4:
            if didSelectCoolButton {
                let coolTempCell = tableView.dequeueReusableCell(withIdentifier: "coolTempCell", for: indexPath) as! CoolTempCell
                coolTempCell.delegate = self
                didShowTempCellButton = true
                return coolTempCell
            } else if didSelectHotButton {
                let hotTempCell = tableView.dequeueReusableCell(withIdentifier: "hotTempCell", for: indexPath) as! HotTempCell
                hotTempCell.delegate = self
                didShowTempCellButton = true
                return hotTempCell
            }
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            didShowTempCellButton = false
            return cell
        default:
            let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteCell
            noteCell.delegate = self
            return noteCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text?.count)! + string.count > 20 {
            return false
        }
        return true
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            
            let deltaY = -intersection.height
            
            if keyBoardNeedLayout {
                UIView.animate(withDuration: duration, delay: 0.0,
                               options: UIViewAnimationOptions(rawValue: curve),
                               animations: {
                                self.view.frame = CGRect(x:0,
                                                         y:deltaY,
                                                         width: self.view.bounds.width,
                                                         height: self.view.bounds.height)
                                self.keyBoardNeedLayout = false
                }, completion: nil)
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            
            let deltaY = intersection.height

            if !keyBoardNeedLayout {
                UIView.animate(withDuration: duration, delay: 0.0,
                               options: UIViewAnimationOptions(rawValue: curve),
                               animations: {
                                self.view.frame = CGRect(x:0,
                                                         y:deltaY,
                                                         width: self.view.bounds.width,
                                                         height: self.view.bounds.height)
                                self.keyBoardNeedLayout = true
                }, completion: nil)
            }
        }
        
    }
    
//    @objc func handleTap(sender: UITapGestureRecognizer) {
//        if sender.state == .began {
//            self.view.endEditing(true) //點擊背景取消鍵盤
//            print("touch table view")
//        }
//        sender.cancelsTouchesInView = false
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VCTitle.text = drink["drinkName"]
        drinkOrder.drinkName = drink["drinkName"]!
        
        loadingView.isHidden = true
        loadingLabel.isHidden = true
        
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        // 另外添加手勢，讓table view 可以點擊
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChangeFrame), name: .UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: .UIKeyboardWillHide , object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

//extension UIScrollView {
//    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        self.endEditing(true)
//        print("tap scroll")
//    }
//}
