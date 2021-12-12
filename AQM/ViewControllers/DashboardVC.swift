//
//  DashboardVC.swift
//  AQM
//
//  Created by bharathi kumar on 08/12/21.
//

import UIKit
import SocketIO

class DashboardVC: UIViewController {
    @IBOutlet weak var cityTableView: UITableView!
    
    var aqiModal: AQIModal?
    var linechartView: DetailedLineChartVC?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "AQI Dashboard"
        aqiModal = AQIModal(vc: self)
        self.cityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "AQICell")
        self.cityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "AQICellHeaderCell")
        self.cityTableView.delegate = aqiModal
        self.cityTableView.dataSource = aqiModal
        self.setNavigationBarBArButton()
        self.initialiseConnection()
        //self.fetchImages()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.aqiModal?.selectedIndex = -1
    }
    
    func setNavigationBarBArButton() {
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
    }
    @objc func infoButtonTapped() {
        let infoVC = InfoVC()
        infoVC.title = "AQI Guide"
        self.present(infoVC, animated: true, completion: nil)
    }
    func initialiseConnection() {
        aqiModal?.connectSocket()
    }
}

extension DashboardVC: AQIModalProtocol {
    func dataUpdated(elements: [AQIElement]) {
    }
    
    func reloadTable() {
        self.cityTableView.reloadData()
    }
    func selectedCity(value: [AQIElement]) {
        linechartView = DetailedLineChartVC()
        linechartView?.aqiData = value
        linechartView?.title = value[0].city
        linechartView?.navigationItem.leftBarButtonItem?.title = "Back"
        self.navigationController?.pushViewController(linechartView!, animated: true)
    }
}
