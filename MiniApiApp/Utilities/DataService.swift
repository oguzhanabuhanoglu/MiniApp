//
//  DataService.swift
//  MiniApiApp
//
//  Created by Oğuzhan Abuhanoğlu on 10.10.2024.
//

import Foundation
import Combine

class DataService {
    
    static let instance = DataService()
    @Published var photos: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    func downloadData() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error downloading data: \(error)")
                }
            } receiveValue: { [weak self] returnedPhotos in
                self?.photos = returnedPhotos
            }
            .store(in: &cancellables)

    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
        
        
    }
}
