//
//  VCDetail.swift
//  StockHunt
//
//  Created by Rajveer Kaur on 02/05/22.
//

import UIKit

struct  StockDetail{
    var Title:String
    var Value:String
}

class VCDetail: UIViewController {
    @IBOutlet weak var lblStockTitle: UILabel!
    @IBOutlet weak var list: UITableView!
    var detailList = [StockDetail]()
    var selectedStock: NSDictionary!{
        didSet {
            configUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configUI(){
        detailList = [StockDetail]()
        self.lblStockTitle
        if let title = selectedStock.value(forKey: "longName") as? String{
            self.lblStockTitle.text = title
        }
        if let exchange = selectedStock.value(forKey: "exchange") as? String{
            detailList.append(StockDetail(Title: "Exchange", Value: "\(exchange)"))
        }
        
        if let price = selectedStock.value(forKey: "bookValue") as? Double{
            detailList.append(StockDetail(Title: "Stock Price", Value: "\u{0024}\(String(format: "%.2f", price))"))
        }
        if let text = selectedStock.value(forKey: "regularMarketChange") as? Double{
            detailList.append(StockDetail(Title: "Change in Price", Value: "\(String(format: "%.2f", text))"))
        }
        
        if let text = selectedStock.value(forKey: "regularMarketChangePercent") as? Double{
            detailList.append(StockDetail(Title: "% Change in Price", Value: "\(String(format: "%.2f", text))"))
        }
        
        if let text = selectedStock.value(forKey: "regularMarketOpen") as? Double{
            detailList.append(StockDetail(Title: "Opening Price", Value: "\u{0024}\(String(format: "%.2f", text))"))
        }
        
        if let text = selectedStock.value(forKey: "regularMarketPreviousClose") as? Double{
            detailList.append(StockDetail(Title: "Previous Close", Value: "\u{0024}\(String(format: "%.2f", text))"))
        }
        
        if let text = selectedStock.value(forKey: "regularMarketDayHigh") as? Double{
            detailList.append(StockDetail(Title: "Day High", Value: "\(String(format: "%.1f", text))"))
        }
        
        if let text = selectedStock.value(forKey: "regularMarketDayLow") as? Double{
            detailList.append(StockDetail(Title: "Day Low", Value: "\(String(format: "%.1f", text))"))
            
        }
        detailList.append(StockDetail(Title: "Market Capitalisation", Value: "\u{0024}278,410M"))
        detailList.append(StockDetail(Title: "Earning Per Share", Value: "1.0"))
        
        list.reloadData()
    }
    
}
extension VCDetail: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellStockDetail", for: indexPath)as! cellStockDetail
        let obj = detailList[indexPath.row]
        cell.objectDetail = obj
        cell.setupUI()
        return cell
    }
    
    
}
