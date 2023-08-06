//
//  ContentView.swift
//  MyDay
//
//  Created by Sp1der on 2023/8/5.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = NewItemViewViewModel()

    var body: some View {
        TabView {
            ToDoListView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .environmentObject(viewModel)
            AboutView()
                .tabItem {
                    Label("About", systemImage: "person")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
