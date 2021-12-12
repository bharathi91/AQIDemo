//
//  Extensions.swift
//  AQM
//
//  Created by bharathi kumar on 09/12/21.
//

import Foundation
import UIKit
extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    func shortDescription() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        return formatter.string(from: self)
    }
}
extension UIColor {
    static func setAQIIndicatorColor(aqi:Double) -> UIColor {
        switch aqi {
        case 0.0..<50.0:
            return UIColor.init(red: 106.0/255.0, green: 165/255.0, blue: 89/255.0, alpha: 1.0)
        case 51.01..<100.0:
            return UIColor.init(red: 170.0/255.0, green: 198/255.0, blue: 100/255.0, alpha: 1.0)
        case 101.01..<200.0:
            return UIColor.init(red: 255.0/255.0, green: 246/255.0, blue: 95/255.0, alpha: 1.0)
        case 201.01..<300.0:
            return UIColor.init(red: 230.0/255.0, green: 159/255.0, blue: 74/255.0, alpha: 1.0)
        case 301.01..<400.0:
            return UIColor.init(red: 216.0/255.0, green: 77/255.0, blue: 62/255.0, alpha: 1.0)
        case 401.01..<500.0:
            return UIColor.init(red: 161.0/255.0, green: 56/255.0, blue: 44/255.0, alpha: 1.0)
        default:
            return.white
        }
    }
}
extension UILabel {
    func animatetextChange(text: String) {
        UIView.transition(with: self,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.text = text
                          }, completion: nil)
    }
}

extension UserDefaults {
    static func saveCityAndImageURLS(dict : [String: String]) {
        UserDefaults.standard.setValue(dict, forKey: "CityImages")
    }
    static func getCityImagesUrl() -> [String: String] {
        if let result = UserDefaults.standard.value(forKey: "CityImages") as? [String: String] {
            return result
        }else{
            return [:]
        }
    }
}
extension UIImageView {
    func addActivityIndicator() {
        let activityInd = UIActivityIndicatorView()
        activityInd.center = CGPoint(x: self.frame.size.width  / 2, y: self.frame.size.height / 2)
        activityInd.color = .white
        if (self.image == nil) {
            self.addSubview(activityInd)
            activityInd.startAnimating()
        }
    }
    func stopActivityIndocator() {
        for view in self.subviews {
            if let indicator = view as? UIActivityIndicatorView {
                indicator.stopAnimating()
            }
        }
    }
    func downloadImageFromURL(url: URL) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url , placeholder: nil, options: nil, progressBlock: nil) { image, error, cache, url in
            self.stopActivityIndocator()
        }
    }
}
