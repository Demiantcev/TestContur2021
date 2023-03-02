//
//  URLSession.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 28.01.2023.
//

import UIKit

enum NetworkManagerError: Error {
    case badResponse(URLResponse?)
    case badData
    case badLocalUrl
}

final class NetworkAPI {
    
    private let cachedImage = NSCache<NSString, NSData>()
    private let decoder = JSONDecoder()
    static let shared = NetworkAPI()
    
    private func download(imageURL: URL, completion: @escaping (Data?, Error?) -> Void) {
        if let imageData = cachedImage.object(forKey: imageURL.absoluteString as NSString) {
            completion(imageData as Data, nil)
            return
        }
        let task = URLSession.shared.downloadTask(with: imageURL) { localUrl, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil, NetworkManagerError.badResponse(response))
                return
            }
            guard let localUrl = localUrl else {
                completion(nil, NetworkManagerError.badLocalUrl)
                return
            }
            do {
                let data = try Data(contentsOf: localUrl)
                self.cachedImage.setObject(data as NSData, forKey: imageURL.absoluteString as NSString)
                completion(data, nil)
            } catch let error as NSError {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func image(post: RocketInfo, completion: @escaping (Data?, Error?) -> Void) {
        guard let flickrImagesRandom = post.flickrImages.randomElement() else {
            return
        }
        guard let url = URL(string: flickrImagesRandom) else {
            return
        }
        DispatchQueue.main.async {
            self.download(imageURL: url, completion: completion)
        }
    }
    
    func image(data: Data?) -> UIImage? {
        if let data = data {
            return UIImage(data: data)
        }
        return UIImage(systemName: "img1")
    }
}
