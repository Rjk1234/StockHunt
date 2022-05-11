//
//  VCCharts.swift
//  StockHunt
//
//  Created by Rajveer Kaur on 02/05/22.
//

import UIKit
import Charts

var players = [String]()
var goals = [Double]()
class VCCharts: UIViewController {
    
    @IBOutlet weak var pieView:PieChartView!
    @IBOutlet weak var lineChartView:LineChartView!
    @IBOutlet weak var barChartView:BarChartView!
    
    @IBOutlet var lblPeriodList: [UILabel]!
    @IBOutlet var btnPeriodList: [UIButton]!
    @IBOutlet var btnChartList: [UIButton]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for btn in self.btnChartList {
            btn.setTitleColor(UIColor(named: "AppColor"), for: .normal)
            btn.layer.borderColor = UIColor.clear.cgColor
            btn.layer.borderWidth = 0.5
            btn.layer.cornerRadius = 5
        }
        btnChartList[0].sendActions(for: .touchUpInside)
    }
    
    
    func customizeChart(dataPoints: [String], values: [Double], index: Int) {
        print(dataPoints)
        print(values)
        switch index {
            
        case 0:
            var dataEntries: [BarChartDataEntry] = []
            for i in 0..<dataPoints.count {
                let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
                dataEntries.append(dataEntry)
            }
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
            let chartData = BarChartData(dataSet: chartDataSet)
            chartDataSet.colors = [UIColor.init(red: 100/255, green: 123/255, blue: 136/255, alpha: 1)]
            barChartView.data = chartData
            barChartView.animate(yAxisDuration: 2.0)
            barChartView.pinchZoomEnabled = false
            barChartView.drawBarShadowEnabled = false
            barChartView.drawBordersEnabled = false
            barChartView.doubleTapToZoomEnabled = false
            barChartView.drawGridBackgroundEnabled = true
            
        case 1:
            var dataEntries: [ChartDataEntry] = []
            for i in 0..<dataPoints.count {
                let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
                dataEntries.append(dataEntry)
            }
            let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "nil")
            lineChartDataSet.colors = [UIColor.init(red: 100/255, green: 123/255, blue: 136/255, alpha: 1)]
            let lineChartData = LineChartData(dataSet: lineChartDataSet)
            lineChartView.data = lineChartData
            
        case 2:
            // 1. Set ChartDataEntry
            var dataEntries: [ChartDataEntry] = []
            for i in 0..<dataPoints.count {
                let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
                dataEntries.append(dataEntry)
            }
            // 2. Set ChartDataSet
            let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
            pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
            // 3. Set ChartData
            let pieChartData = PieChartData(dataSet: pieChartDataSet)
            let format = NumberFormatter()
            format.numberStyle = .none
            let formatter = DefaultValueFormatter(formatter: format)
            pieChartData.setValueFormatter(formatter)
            // 4. Assign it to the chart’s data
            pieView.data = pieChartData
        default : break
        }
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        return colors
    }
    @IBAction func onSelectChartType(_ sender: UIButton){
        print(sender.tag)
        for btn in self.btnChartList {
            btn.setTitleColor(UIColor(named: "AppColor"), for: .normal)
            btn.layer.borderColor = UIColor.clear.cgColor
        }
        self.btnChartList[sender.tag].setTitleColor(UIColor(named: "AppSelect"), for: .normal)
        self.btnChartList[sender.tag].layer.borderColor = UIColor(named: "AppSelect")!.cgColor
        self.pieView.isHidden = true
        self.barChartView.isHidden = true
        self.lineChartView.isHidden = true
        switch sender.tag{
        case 0:
            self.barChartView.isHidden = false
        case 1:
            self.lineChartView.isHidden = false
        case 2:
            self.pieView.isHidden = false
        default: break
        }
        customizeChart(dataPoints: players, values: goals, index: sender.tag)
    }
    
    @IBAction func onSelectPeriod(_ sender: UIButton){
        print(sender.tag)
        resetAll()
        setSelect(index:sender.tag)
    }
    func resetAll(){
        for btn in self.btnPeriodList {
            btn.isSelected = false
            btn.tintColor = UIColor(named: "AppColor")
        }
        for lbl in lblPeriodList {
            lbl.textColor = UIColor(named: "AppColor")
        }
    }
    func setSelect(index:Int){
        self.btnPeriodList[index].isSelected = true
        self.btnPeriodList[index].tintColor = UIColor(named: "AppSelect")
        self.lblPeriodList[index].textColor = UIColor(named: "AppSelect")
    }
}
