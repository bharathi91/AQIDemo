//
//  AQIModal.swift
//  AQM
//
//  Created by bharathi kumar on 09/12/21.
//

import Foundation
import UIKit


class AQIModal: NSObject {
    var viewController: UIViewController?
    private var aqiData: [AQIElement] = []
    private var aqiWholeData: [[AQIElement]] = []
    var aqiDelegate: AQIModalProtocol?
    var selectedIndex = -1
    init(vc: UIViewController) {
        self.viewController = vc
        self.aqiDelegate = self.viewController as? AQIModalProtocol
    }
    
    func connectSocket()  {
        SocketHelper.shared.connectSocket { status in
            print(status)
            var updatedArray = self.aqiWholeData
            if self.aqiWholeData.count == 0 {
                for element in status.enumerated() {
                    updatedArray.append([element.element])
                    self.aqiWholeData = updatedArray
                }
                return
            }
            for (_, element) in status.enumerated() {
                var isFound = false
                var foundIndex = -1
                innerLoop: for (index1, element1) in updatedArray.enumerated() {
                    secondInnerLoop: for (_, element2) in element1.enumerated() {
                        if element2.city == element.city {
                            isFound = true
                            foundIndex = index1
                            break innerLoop
                        }
                    }
                }
                if isFound {
                    self.aqiWholeData[foundIndex].append(element)
                } else{
                    self.aqiWholeData.append([element])
                    if ImageURLCache.shared.imageURLDict[element.city] == nil {
                        ImageURLCache.shared.imageURLDict[element.city] = ""
                    }
                }
            }
            self.aqiDelegate?.reloadTable()
            if self.selectedIndex >= 0 {
                self.aqiDelegate?.dataUpdated(elements: self.aqiWholeData[self.selectedIndex])
            }
           
        }
    }
}

extension AQIModal : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.aqiWholeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:AQITableViewCell? = tableView.dequeueReusableCell(withIdentifier: AQITableViewCell.identifier) as? AQITableViewCell
        if (cell == nil) {
            let nib:Array = Bundle.main.loadNibNamed("AQITableViewCell", owner: self, options: nil)!
            cell = nib[0] as? AQITableViewCell
        }
        if let element = self.aqiWholeData[indexPath.row].last {
            cell?.data = element
        } else {
            print("error")
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.aqiDelegate?.selectedCity(value: self.aqiWholeData[indexPath.row])
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        let cityLabel = UILabel(frame: CGRect(x: 0, y: 5, width: tableView.frame.size.width / 3, height: 20))
        cityLabel.font = UIFont.systemFont(ofSize: 20)
        cityLabel.text = "City"
        cityLabel.textAlignment = .center
        view.addSubview(cityLabel)
        view.backgroundColor = UIColor.green // Set your background color
        
        let aqiLabel = UILabel(frame: CGRect(x: cityLabel.frame.width , y: 5, width: tableView.frame.size.width / 3, height: 20))
        aqiLabel.font = UIFont.systemFont(ofSize: 20)
        aqiLabel.text = "AQI Value"
        aqiLabel.textAlignment = .center
        view.addSubview(aqiLabel)
        view.backgroundColor = UIColor.green
        
        let timeStampLabel = UILabel(frame: CGRect(x: aqiLabel.frame.width + aqiLabel.frame.origin.x, y: 5, width: tableView.frame.size.width / 3, height: 20))
        timeStampLabel.font = UIFont.systemFont(ofSize: 20)
        timeStampLabel.text = "TimeStamp"
        timeStampLabel.textAlignment = .center
        view.addSubview(timeStampLabel)
        view.backgroundColor = UIColor.green
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
}
