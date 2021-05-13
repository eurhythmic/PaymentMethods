//
//  UIImageView.swift
//  PaymentMethods
//
//  Created by RnD on 5/11/21.
//

import UIKit

extension UIImageView {
    /// Asynchronously load an image from a URL string
    func getImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return
            }
            guard error == nil else {
                print(error!)
                return
            }
            guard let image = UIImage(data:data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
