//
//  ContentView.swift
//  MiniApiApp
//
//  Created by Oğuzhan Abuhanoğlu on 10.10.2024.
//

import SwiftUI

struct MiniApp: View {
    
    @StateObject var vm = MiniAppViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { data in
                    ListRowView(data: data)
                }
            }
            .listStyle(.plain)
            .navigationTitle("MiniApp")
        }
        
    }
}

#Preview {
    MiniApp()
}
