//
//  MyDayApp.swift
//  MyDay
//
//  Created by Sp1der on 2023/8/5.
//

import SwiftUI

@main
struct MyDayApp: App {
    @StateObject var viewModel = NewItemViewViewModel()
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(viewModel)
        }
    }
}
