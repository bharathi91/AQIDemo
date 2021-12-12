//
//  AQIData.swift
//  AQM
//
//  Created by bharathi kumar on 09/12/21.
//

import Foundation

typealias AQIData = [AQIElement]

struct AQIElement: Codable {

    let city: String
    var aqi: Double
    var timeStamp: Date?
    var imageURL: String?
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case aqi = "aqi"
        case timeStamp = "timeStamp"
        case imageURL = "imageURL"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.aqi = try container.decodeIfPresent(Double.self, forKey: .aqi) ?? 0.0
        self.timeStamp = try container.decodeIfPresent(Date.self, forKey: .timeStamp) ?? Date()
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .timeStamp) ?? ""
        self.updateValues()
    }
    mutating func updateValues(){
        self.aqi = Double(round(100 * self.aqi) / 100)
    }
}
