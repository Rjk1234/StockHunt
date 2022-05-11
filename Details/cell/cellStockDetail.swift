//
//  cellStockDetail.swift
//  StockHunt
//
//  Created by Rajveer Kaur on 02/05/22.
//

import UIKit

class cellStockDetail: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    var objectDetail : StockDetail!
    
    func setupUI(){
        if objectDetail == nil {return}
        lblTitle.text = objectDetail.Title ?? ""
        lblValue.text = objectDetail.Value ?? ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

