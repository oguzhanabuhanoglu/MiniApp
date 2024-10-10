//
//  ListRowView.swift
//  MiniApiApp
//
//  Created by Oğuzhan Abuhanoğlu on 10.10.2024.
//

import SwiftUI

struct ListRowView: View {
    
    let data: PhotoModel
    
    var body: some View {
        HStack {
            ImagesView(url: data.url)
                .frame(width: 75, height: 75)
            
            VStack(alignment: .leading) {
                Text(data.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text(data.url)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ListRowView(data: PhotoModel(albumId: 1, id: 1, title: "Title", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/771796"))
}
