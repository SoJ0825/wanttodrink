import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var recordBoard: UIView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    let headerViewHeight: CGFloat = 30
    
    var orderLists = [[String: String]]()
    
    var customers = [String]()
//    var customerOrder = [String: String]()
    var customerOrderLists = [[[String: String]]]()
    var customerCosts = [String]()
    var totalPrice = 0
    var totalAmount = 0
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return customerOrderLists.count //customers.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerViewHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = OrderHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: headerViewHeight))
        header.updateCustomerData(name: customers[section], cost: customerCosts[section])
        
        return header
        
    }

    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        customerNameLabel.text = customers[section]
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerOrderLists[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderCell
            cell.updateUI(drink: customerOrderLists[indexPath.section][indexPath.row])
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "訂購清單"
        let headerNib = UINib(nibName: "OrderHeaderView", bundle: nil)
        orderTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "headerView")
        
        JsonMenu.shared.getJsonOrder { orderDictionaryLists in
            self.orderLists = orderDictionaryLists
            DispatchQueue.main.async {
                
                for data in self.orderLists {
                    self.totalPrice +=  Int(data["totalprice"]!)!
                    self.totalAmount += Int(data["amount"]!)!
                    
                    if self.customers.contains(data["name"]!) == false {
                        self.customers.append(data["name"]!)
                    }
                }
//                print(self.customers)
                for customer in self.customers {
                    var totalPrice = 0
                    var order = [[String: String]]()
                    for data in self.orderLists {
                        if data["name"] == customer {
                            totalPrice += Int(data["totalprice"]!)!
                            order.append(data)
                        }
                    }
                    self.customerOrderLists.append(order)
                    self.customerCosts.append("\(totalPrice)")
                }
                
                self.totalPriceLabel.text = "\(self.totalPrice)"
                self.totalAmountLabel.text = "\(self.totalAmount)"
                self.orderTableView.reloadData()
            }
        }

        recordBoard.layer.cornerRadius = 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
