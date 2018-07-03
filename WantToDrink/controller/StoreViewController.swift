//
//  StoreViewController.swift
//  WantToDrink
//
//  Created by 高菘駿 on 2018/6/28.
//  Copyright © 2018年 SoJ. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{

    @IBOutlet weak var topStoreImageView: UIImageView!
    weak var bottomStoreImageView: UIImageView!
    
    @IBOutlet weak var tableViewSuperView: UIView!
    
    @IBOutlet weak var storeTableView: UITableView!
    
    var lastContentOffset: CGFloat = 0.0
    var firstVisibleRow: Int = 0
    
    var storeList = [String]()
    var storeName: String?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath) as! StoreCell
        cell.storeImageView.image = UIImage(named: storeList[indexPath.row])
        cell.storeName.text = storeList[indexPath.row]
//        if indexPath.row % 2 == 0 {
//        cell.storeImageView.image = #imageLiteral(resourceName: "五十嵐")
//        } else {
//            cell.storeImageView.image = #imageLiteral(resourceName: "雙囍茶會")
//        }
//        cell.storeName.text = "\(indexPath.row)"
        
//        if tableView.isDragging && storeList != nil {
////            print(tableView.indexPathsForVisibleRows?[0])
////            topStoreImageView.image = tableView.indexPathsForVisibleRows?[0]
//            firstVisibleRow = (tableView.indexPathsForVisibleRows?[0].row)!
//        }

        return cell
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        if lastContentOffset < storeTableView.contentOffset.y {
//            print(storeTableView.contentOffset)
////            topStoreImageView.frame.origin.y +=
////            bottomStoreImageView.image = UIImage(named: storeList[firstVisibleRow + 1])
//        } else if lastContentOffset > storeTableView.contentOffset.y {
////            topStoreImageView.image = UIImage(named: storeList[firstVisibleRow])
////            bottomStoreImageView.image = UIImage(named: storeList[firstVisibleRow + 1])
//        }
//        lastContentOffset = storeTableView.contentOffset.y
//
//    }                                                                                                                                                                                                                                                                                                                                                                               
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        storeName = storeList[indexPath.row]
        performSegue(withIdentifier: "showDrinkListSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDrinkListSegue" {
//            let navigationVC = segue.destination as! UINavigationController
//            let drinkListVC = navigationVC.topViewController as! DrinkListViewController
            let drinkListVC = segue.destination as! DrinkListViewController
            drinkListVC.storeName = storeName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.cgColor]
        gradientLayer.frame = tableViewSuperView.bounds
        gradientLayer.locations = [0, 0.05, 1]
        tableViewSuperView.layer.mask = gradientLayer
        
        JsonMenu.shared.getJsonStoreList { (storeList) in
            self.storeList = storeList
            
            DispatchQueue.main.async {
                self.storeTableView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
