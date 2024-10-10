//
//  MiniAppViewModel.swift
//  MiniApiApp
//
//  Created by Oğuzhan Abuhanoğlu on 10.10.2024.
//

import Foundation
import Combine

class MiniAppViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    let dataService = DataService.instance
    var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photos
            .sink { [weak self] returnedPhotoArray in
                self?.dataArray = returnedPhotoArray
            }
            .store(in: &cancellables)
    }
}
