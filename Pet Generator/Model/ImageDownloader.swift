//
//  ImageDownloader.swift
//  Pet Generator
//
//  Created by Vitor Sousa on 01/05/2023.
//

import Foundation

class ImageDownloader {
    static let shared = ImageDownloader()
    
    func fromUrl(url: URL, completion: @escaping((Data?) -> Void)) {
        URLSession.shared.dataTask(with: url) { d, _, _ in
            DispatchQueue.main.async {
                completion(d)
            }
        }.resume()
    }
}
