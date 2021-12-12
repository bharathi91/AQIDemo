//
//  AQITableViewCell.swift
//  AQM
//
//  Created by bharathi kumar on 09/12/21.
//

import UIKit

class AQITableViewCell: UITableViewCell {
    static let identifier = "AQICell"
    @IBOutlet weak var imageCity: UIImageView!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelAQIRate: UILabel!
    @IBOutlet weak var labelTimeStamp: UILabel!
    @IBOutlet weak var aqiIndicatorView: UIView!
    
    var data: AQIElement? {
        didSet {
            
            labelCity.animatetextChange(text: data?.city ?? "")
            if let aqi =  String(format: "%.2f", Double(data?.aqi ?? 0.0)) as? String {
                labelAQIRate.animatetextChange(text:aqi)
                self.aqiIndicatorView.backgroundColor = UIColor.setAQIIndicatorColor(aqi: Double(aqi) ?? 0.0)
            }
            if let updatedTime = data?.timeStamp?.timeAgoDisplay() {
                labelTimeStamp.animatetextChange(text: "Updated \(updatedTime)")
            }
            if let imageLink = data?.imageURL, imageLink != "" {
                let url = URL(string: imageLink)
                imageCity.kf.setImage(with: url)
            } else {
                if let city = data?.city, let imageUrl = ImageURLCache.shared.imageURLDict[city], imageUrl != "", let url = URL(string: imageUrl) {
                    imageCity.addActivityIndicator()
                    imageCity.downloadImageFromURL(url: url)
                } else {
                    ImageDownloader.fetchImages(city: data?.city ?? "Chennai", imageView: imageCity) { [self] url in
                        ImageURLCache.shared.imageURLDict[data!.city] = url
                        UserDefaults.saveCityAndImageURLS(dict: ImageURLCache.shared.imageURLDict)
                    }
                }
            }
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.labelCity.text = ""
        self.labelAQIRate.text = ""
        self.labelTimeStamp.text = ""
        self.aqiIndicatorView.backgroundColor = .clear
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

