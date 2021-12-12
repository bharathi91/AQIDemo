//
//  ImageDownloader.swift
//  AQM
//
//  Created by bharathi kumar on 10/12/21.
//

import Foundation
import UIKit
import Kingfisher

class ImageDownloader {
    static let unSplashClientID = "vJABtil8axRYEksOYJLDsbPozJA6_nBOFV6no3EbdzA"
    static func fetchImages(city: String, imageView: UIImageView, completion : @escaping (String) -> ()) {
        let address = "https://api.unsplash.com/search/photos?page=1&query=\(city)&per_page=1&client_id=\(unSplashClientID)&w=320&h=150"
        if let url = URL(string: address) {
            imageView.addActivityIndicator()
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                }else if let response = response as? HTTPURLResponse, let data = data {
                    print("Status Code: \(response.statusCode)")
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                        if let results = json?["results"] as? [[String : Any]], let downloadLinks = results[0]["links"] as? [String : Any] {
                            if let urlString = downloadLinks["download"] as? String {
                                DispatchQueue.main.async {
                                    if let url = URL(string: urlString) {
                                        completion(urlString)
                                        imageView.downloadImageFromURL(url: url)
                                    }
                                }
                            }
                        }
                    }catch{
                        print("erroMsg")
                    }
                }
            }.resume()
        }
    }
}
