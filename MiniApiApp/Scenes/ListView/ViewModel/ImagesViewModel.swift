//
//  DownloadImagesViewModel.swift
//  MiniApiApp
//
//  Created by Oğuzhan Abuhanoğlu on 10.10.2024.
//

import Foundation
import SwiftUI
import Combine

class ImagesViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var image: UIImage? = nil
    let urlString: String
    var cancellables = Set<AnyCancellable>()
    
    let localDataManager = PhotoModelCacheManager.instance
    //let localDataManager = PhotoModelFileManager.instance
    
    
    
    init(url: String) {
        urlString = url
        downloadImageIfNeeded()
        //downloadImage()
    }
    
    func downloadImageIfNeeded() {
        if let savedImage = localDataManager.get(key: urlString) {
            image = savedImage
            print("cached")
        } else {
            downloadImage()
            print("downloaded")
        }
    }
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map { UIImage(data: $0.data) }
//            .map { data, response -> UIImage? in
//                return UIImage(data: data)
//            }
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard let self = self,
                      let image = returnedImage else { return }
                self.image = image
                self.localDataManager.add(key: urlString, value: image)
            }
            .store(in: &cancellables)

    }
}
