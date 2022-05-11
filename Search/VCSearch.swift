//
//  VCSearch.swift
//  StockHunt
//
//  Created by Rajveer Kaur on 29/04/22.
//

import UIKit

class VCSearch: UIViewController  {
    @IBOutlet weak var tblStockList: UITableView!
    @IBOutlet weak var tfSearchBar: UITextField!
    @IBOutlet weak var lblPlaceHolder: UILabel!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var btnBack: UIButton!
    var stockList = [NSDictionary]()
    var stockFilteredList = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfSearchBar.delegate = self
    }
    
    func getData(searchString: String){
        WebService.shared.getSearchResult(searchString: searchString){ result, error in
            if error != nil {
                return
            }
            if let quoteList = result!.value(forKey: "quotes") as? [NSDictionary]{
                if quoteList.isEmpty {return}
                DispatchQueue.main.async {
                    self.stockList = quoteList
                    self.stockFilteredList = quoteList
                    self.tblStockList.reloadData()
                }
            }
        }
    }
    
    @IBAction func onTapBack(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: Search Handle
extension VCSearch: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, delay: 0.0){
            self.top.constant = 5
        }
        self.lblPlaceHolder.textColor = UIColor.init(named: "AppSelect")
        self.lblPlaceHolder.font = UIFont.boldSystemFont(ofSize: 12.0)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let string1 = string
        let string2 = tfSearchBar.text
        var finalString = ""
        if string.count > 0 {
            finalString = string2! + string1
        }
        else if string2!.count > 0{
            finalString = String(string2!.dropLast())
        }
        filteredArray(searchString:finalString)
        return true
    }
    
    func filteredArray(searchString: String){
        let trimmedString = searchString.trimmingCharacters(in: .whitespaces)
        if trimmedString == ""{
            self.stockFilteredList = self.stockList
            self.tblStockList.reloadData()
            return
        }
        if trimmedString.count > 0 {
            self.getData(searchString: searchString)
        }
    }
    
}

//MARK: Tableview handle
extension VCSearch: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockFilteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSearch", for: indexPath)as! cellSearch
        if let obj = stockFilteredList[indexPath.row] as? NSDictionary {
            cell.StockObject = obj
            cell.setupData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let obj = stockFilteredList[indexPath.row] as? NSDictionary {
            if let symbol = obj.value(forKey: "symbol") as? String{
                if SelectedStocks.contains(symbol){
                    let index = SelectedStocks.firstIndex(of: symbol)
                    self.alertwith(title: "Add Form", message: "Already in WatchList. Want to remove?", options: ["Ok","Cancel"], completion: { result in
                        if result == 0 {
                            SelectedStocks.remove(at: index!)
                            Functions.storeToPersistent(List: SelectedStocks)
                        }
                    })
                }else{
                    self.alertwith(title: "Add Form", message: "Add to Watchlist?", options: ["Ok","Cancel"], completion: { result in
                        if result == 0 {
                            SelectedStocks.append(symbol)
                            Functions.storeToPersistent(List: SelectedStocks)
                        }
                    })
                }
            }
        }
    }
    
}
