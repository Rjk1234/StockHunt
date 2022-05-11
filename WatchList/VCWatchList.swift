//
//  VCWatchList.swift
//  StockHunt
//
//  Created by Rajveer Kaur on 29/04/22.
//

import UIKit


class VCWatchList: UIViewController {
    @IBOutlet weak var tblList:UITableView!
    @IBOutlet weak var btnAddNew:UIButton!
    
    var list = [NSDictionary]()
    var timer = Timer()
    
    //MARK: View Lifecycle Handle
    override func viewDidLoad() {
        super.viewDidLoad()
        tblList.register(UINib(nibName: "cellWatchList", bundle: nil), forCellReuseIdentifier: "cellWatchList")
        btnAddNew.layer.cornerRadius = btnAddNew.frame.size.height/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
//        setupTinmer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    //MARK: API fetch Handle
    func setupTinmer(){
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 15,
        target: self,
        selector: #selector(update),
        userInfo: nil,
        repeats: true)
    }
   
    @objc func update() {
        getData()
    }
    
    func getData(){
        WebService.shared.getWatchList(symbolArr: SelectedStocks){ result, error in
            if error != nil {
                return
            }
            if let data = result!.value(forKey: "quoteResponse") as? NSDictionary {
                if let list = data.value(forKey: "result") as? [NSDictionary]{
                self.list = list
                DispatchQueue.main.async {
                    self.tblList.reloadData()
                }
                }
            }
        }
    }
    
    @IBAction func  onTapAdd(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "VCSearch") as! VCSearch
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Tableview Handle
extension VCWatchList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellWatchList", for: indexPath)as! cellWatchList
        if let obj = list[indexPath.row] as? NSDictionary{
            cell.stockObject = obj
            cell.setupData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let obj = list[indexPath.row] as? NSDictionary{
        let vc = storyboard?.instantiateViewController(withIdentifier: "VCPageHandler") as! VCPageHandler
        vc.selectedStock = obj
        navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
