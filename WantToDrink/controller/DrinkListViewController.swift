import UIKit

class DrinkListViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var drinkTypeCollectionView: UICollectionView!
    
    var storeName: String? = "雙囍茶會" //"五十嵐"
    
    var drinkMenu = [[String: String]]()
    
    var drinkType = [String]()
    var detailMenu = [[String: String]]()
    var searchDrinkMenu = [[String: String]]()
    
    var drinkTypeHighLights = [Bool]()
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if navigationItem.searchController?.isActive == true {
            return searchDrinkMenu.count
        } else {
            return detailMenu.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102 // view.frame.height / 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        if navigationItem.searchController?.isActive == true {
//            cell.updateUI(drink: searchDrinkMenu[indexPath.row])
            cell.createNewPrice(drink: searchDrinkMenu[indexPath.row])
        } else {
//            cell.updateUI(drink: detailMenu[indexPath.row])
            cell.createNewPrice(drink: detailMenu[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var drink = [String: String]()
        if navigationItem.searchController?.isActive == true {
            drink = searchDrinkMenu[indexPath.row]
        } else {
            drink = detailMenu[indexPath.row]
        }
        
        let orderFormVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "orderFormVC") as! OrderFormViewController
        orderFormVC.drink = drink
        orderFormVC.drinkOrder.store = storeName!
        present(orderFormVC, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchString = searchController.searchBar.text!
        searchDrinkMenu = drinkMenu.filter { (list) -> Bool in
            
            return list["drinkName"]!.contains(searchString)
        }
        menuTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinkType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drinkTypeCell", for: indexPath) as! DrinkTypeCell
        cell.update(tittle: drinkType[indexPath.item])
        
        if drinkTypeHighLights == [] {
            drinkTypeHighLights.append(true)
            for _ in 1...drinkType.count {
                drinkTypeHighLights.append(false)
            }
        }
        
        cell.backgroundHighlight(bool: drinkTypeHighLights[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for i in 0...(drinkTypeHighLights.count - 1)  {
            drinkTypeHighLights[i] = false
        }
        drinkTypeHighLights[indexPath.item] = true
        
        setDetailMenu(drinkType: drinkType[indexPath.item])
        
        drinkTypeCollectionView.reloadData()
        menuTableView.reloadData()
    }
    
    func setDetailMenu(drinkType: String) {
        detailMenu = []
        
        drinkMenu.forEach({ (dictionary) in
            if dictionary["drinkType"]! == drinkType {
                detailMenu.append(dictionary)
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white, NSAttributedStringKey.font: UIFont(name: "Arial", size: 20)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = storeName
        
        navigationController?.navigationBar.prefersLargeTitles = false
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        //利用 KVC 找到 searchBar 裡面的 searchfield (本身是繼承UITextField)
        if let searchfield = searchController.searchBar.value(forKey: "searchField") as? UITextField{
            searchfield.tintColor = .black
            searchfield.layer.backgroundColor = UIColor.white.cgColor //layer background 才會決定最後背景色
            searchfield.backgroundColor = UIColor.red
            searchfield.layer.cornerRadius = 5
            searchfield.layer.borderColor = UIColor.white.cgColor
            searchfield.layer.borderWidth = 2
        }

        //searchController.searchBar.barStyle = .black   // 設定成 black 才能讓 searchfield 的字是白色的
        searchController.searchBar.tintColor = .white  // cancel按鈕顏色 會同步影響 searchfield中的 tintColor => 游標會變白色
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true //讓 search bar 固定顯示在畫面上
        
        menuTableView.contentInsetAdjustmentBehavior = .never
        
        JsonMenu.shared.getJsonMenu(with: storeName!, completion: { drinkDictionaryLists in
            self.drinkMenu = drinkDictionaryLists
            self.drinkMenu.forEach({ (dictionary) in
                if self.drinkType.contains(dictionary["drinkType"]!) == false {
                    self.drinkType.append(dictionary["drinkType"]!)
                }
            })

            DispatchQueue.main.async {
                self.setDetailMenu(drinkType: self.drinkType[0])
                self.menuTableView.reloadData()
                self.drinkTypeCollectionView.reloadData()
            }
        })

    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
