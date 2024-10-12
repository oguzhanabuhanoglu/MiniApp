//
//  ImagesView.swift
//  MiniApiApp
//
//  Created by Oğuzhan Abuhanoğlu on 10.10.2024.
//

import SwiftUI

struct ImagesView: View {
    
    @StateObject var vm: ImagesViewModel
    
    init(url: String, key: String) {
        _vm = StateObject(wrappedValue: ImagesViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                ProgressView()
            } else if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    ImagesView(url: "https://via.placeholder.com/600/92c952", key: "1")
        .frame(width: 55, height: 55)
}
