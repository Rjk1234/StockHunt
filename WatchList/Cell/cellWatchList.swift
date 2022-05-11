//
//  cellWatchList.swift
//  StockHunt
//
//  Created by Rajveer Kaur on 29/04/22.
//

import UIKit

class cellWatchList: UITableViewCell {

    @IBOutlet weak var cardView:UIView!
    @IBOutlet weak var lblStockTitle:UILabel!
    @IBOutlet weak var lblSymbol:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var lblHiLoColorTop:UILabel!
    @IBOutlet weak var lblHiLoColorBottom:UILabel!
    @IBOutlet weak var lblHiLoTop:UILabel!
    @IBOutlet weak var lblPriceBottom:UILabel!
    @IBOutlet weak var btnArrow:UIButton!
    
    var stockObject = NSDictionary()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.layer.cornerRadius = 3
        cardView.makeShadowDrop()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(){
        if let title = stockObject.value(forKey: "longName") as? String{
            lblStockTitle.text = title
        }
        if let symbol = stockObject.value(forKey: "symbol") as? String{
            if let exchange = stockObject.value(forKey: "exchange") as? String{
            lblSymbol.text = "\(symbol)/\(exchange)"
            }
        }
        if let price = stockObject.value(forKey: "bookValue") as? Double{
            lblPrice.text = "\u{0024}\(String(format: "%.2f", price))"
        }
        
        if let text = stockObject.value(forKey: "regularMarketDayHigh") as? Double{
            lblHiLoTop.text = "\(String(format: "%.1f", text))"
        }
        if let text = stockObject.value(forKey: "regularMarketDayLow") as? Double{
            lblPriceBottom.text = "\(String(format: "%.1f", text))"
        }
        if let text = stockObject.value(forKey: "regularMarketChange") as? Double{
            lblHiLoColorTop.text = "\(String(format: "%.2f", text))"
            if text > 0 {
                lblHiLoColorTop.textColor =  UIColor.init(named: "AppTextGreen")
            }else{
                lblHiLoColorTop.textColor =  UIColor.red
            }
        }
        if let text = stockObject.value(forKey: "regularMarketChangePercent") as? Double{
            lblHiLoColorBottom.text = "\(String(format: "%.2f", text))"
            if text > 0 {
                lblHiLoColorBottom.textColor =  UIColor.init(named: "AppTextGreen")
            }else{
                lblHiLoColorBottom.textColor =  UIColor.red
            }
        }
    }
}

