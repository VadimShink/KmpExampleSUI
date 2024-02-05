//
//  MVIApp.swift
//  MVI
//
//  Created by Константин Савялов on 05.02.2024.
//

import SwiftUI

@main
struct MVIApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel(text: "Text", changeValue: "Password"))
        }
    }
}
