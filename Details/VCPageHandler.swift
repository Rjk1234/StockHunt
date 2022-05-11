//
//  VCPageHandler.swift
//  StockHunt
//
//  Created by Rajveer Kaur on 03/05/22.
//

import UIKit

class VCPageHandler: UIViewController {
    lazy var orderedViewControllers: [UIViewController] = {
        return [
            self.newVc(viewController: "VCDetail"),
            self.newVc(viewController: "VCCharts"),
        ]
    }()
    var viewControllers : [UIViewController]!
    var selectedIndex: Int = 0
    var pageIndex : Int = 0
    var pageVc: UIPageViewController!
    @IBOutlet weak var contentView: UIView!
    var pageControl = UIPageControl()
    var selectedStock : NSDictionary!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        if self.selectedStock != nil {
            if let symbol = selectedStock.value(forKey: "symbol") as? String{
                getDataForChart(Interval: 1, Range: 6, symbol: symbol)
            }
        }
        
        setupPageControl()
        viewControllers = [self.newVc(viewController: "VCCharts"),
                           self.newVc(viewController: "VCDetail"),
        ]
        pageVc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVc.dataSource = self
        pageVc.delegate = self
        
        DispatchQueue.main.async {
            if let firstViewController = self.orderedViewControllers.first {
                self.pageVc.setViewControllers([firstViewController],
                                               direction: .forward,
                                               animated: true,
                                               completion: nil)
                if let visibleVC = self.pageVc.viewControllers?.first as? VCDetail {
                    visibleVC.selectedStock =  self.selectedStock
                }
            }
            self.addChild(self.pageVc)
        }
        pageVc.view.frame = CGRect(x:0, y: 0, width: self.contentView.bounds.width, height: self.contentView.bounds.height)
        self.contentView.addSubview(pageVc.view)
        pageVc.didMove(toParent: self)
    }
    
    func getDataForChart(Interval: Int, Range: Int, symbol: String){
        Functions.showActivityIndicator(In: self)
        WebService.shared.getChartData(interval: Interval, range: Range, symbol: symbol) {result, error in
            print(result)
            DispatchQueue.main.async {
                Functions.hideActivityIndicator()
            }
            if error != nil {return}
            guard let data = result as? NSDictionary else {return}
            if let chartData = data.value(forKey: "chart")as? NSDictionary{
                if let arr = chartData.value(forKey: "result") as? [NSDictionary]{
                    
                    let timestamparr = (arr[0] as! NSDictionary).value(forKey: "timestamp")as! NSArray
                    players.removeAll()
                    goals.removeAll()
                    for i in 0..<7{
                        //                        print(Date(timeIntervalSince1970:  timestamparr[i] as! Double))
                        let dateStr = self.getdate(date: Date(timeIntervalSince1970:  timestamparr[i] as! Double))
                        players.append("\(dateStr)")
                    }
                    if let indicator = arr[0].value(forKey: "indicators") as? NSDictionary{
                        if let quote = indicator.value(forKey: "quote") as? [NSDictionary]{
                            if let object = quote[0].value(forKey: "open") as? NSArray{
                                print(object.count)
                                for i in 0..<7{
                                    goals.append( object[i] as! Double )
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func onTapBack(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    func setupPageControl() {
        let height =  UIScreen.main.bounds.size.height/9
        print(height)
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height-height, width: UIScreen.main.bounds.width, height: 50))
        self.pageControl.numberOfPages = 2
        self.pageControl.tintColor = UIColor.lightGray
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = UIColor.clear
        self.view.addSubview(pageControl)
    }
    
    
    func getdate(date:Date)->String{
        let date = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let yearString = dateFormatter.string(from: date)
        return yearString
    }
}

//MARK: UIPageController handle
extension VCPageHandler :UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let visibleViewController = pageViewController.viewControllers?.first
        let index = orderedViewControllers.firstIndex(of: visibleViewController!)
        pageControl.currentPage = Int(index!)
        if let visibleVC = visibleViewController as? VCCharts {
            
        }
        if let visibleVC = visibleViewController as? VCDetail {
            visibleVC.selectedStock = self.selectedStock
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
    
    
}


