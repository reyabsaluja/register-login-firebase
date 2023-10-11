//
//  ImageLoader.swift
//  FBAuth
//
//  Created by Reyab Saluja on 2023-10-06.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    @Published var error: Error?

    func load(from url: URL) {
        self.isLoading = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let data = data, let uiImage = UIImage(data: data) {
                    self.image = uiImage
                } else if let error = error {
                    self.error = error
                    print("Error loading image: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
