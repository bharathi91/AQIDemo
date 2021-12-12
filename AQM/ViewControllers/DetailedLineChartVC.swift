//
//  DetailedLineChartVC.swift
//  AQM
//
//  Created by bharathi kumar on 12/12/21.
//

import UIKit
import Charts
import TinyConstraints

class DetailedLineChartVC: UIViewController {

    var chartData: [ChartDataEntry]?
    var aqiData : [AQIElement]? 
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBlue
        chartView.leftAxis.labelPosition = .insideChart
        chartView.xAxis.labelPosition = .bottomInside
        chartView.animate(xAxisDuration: 1.0)
        return chartView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.height(to: view)
        setChartData()
    }
    func setChartData() {
        chartData = []
        if let data = aqiData {
            for (index,_) in data.enumerated() {
                let chartDataEntry = ChartDataEntry(x: Double(index), y: data[index].aqi)
                chartData?.append(chartDataEntry)
            }
        }
        let set1: LineChartDataSet = LineChartDataSet(entries: chartData ?? [], label: "AQI Data")
        let data = LineChartData(dataSet: set1)
        lineChartView.data = data
    }
}

extension DetailedLineChartVC : ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
}
