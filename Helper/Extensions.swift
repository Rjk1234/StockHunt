//
//  Extensions.swift
//  StockHunt
//
//  Created by Rajveer Kaur on 04/05/22.
//

import UIKit


extension UIView{
    
    func makeShadowDrop(){
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 4.0
    }
}
extension UIViewController {
    
    func alertwith(title: String, message: String, options: [String], completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
