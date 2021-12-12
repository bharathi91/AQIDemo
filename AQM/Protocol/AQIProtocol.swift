//
//  AQIProtocol.swift
//  AQM
//
//  Created by bharathi kumar on 12/12/21.
//

import Foundation

protocol AQIModalProtocol {
    func reloadTable()
    func dataUpdated(elements: [AQIElement])
    func selectedCity(value: [AQIElement])
}
