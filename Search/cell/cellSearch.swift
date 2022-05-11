//
//  cellSearch.swift
//  StockHunt
//
//  Created by Rajveer Kaur on 30/04/22.
//

import UIKit

class cellSearch: UITableViewCell {
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblSymbol:UILabel!
    @IBOutlet weak var lblExchange:UILabel!
    var StockObject = NSDictionary()
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setupData(){
        if StockObject != nil {
            if let title = StockObject.value(forKey: "longname") as? String{
                self.lblTitle.text = title
            }
            if let symbol = StockObject.value(forKey: "symbol") as? String{
                self.lblSymbol.text = symbol
            }
            if let exchange = StockObject.value(forKey: "exchange") as? String{
                self.lblExchange.text = exchange
            }
        }
    }

}
