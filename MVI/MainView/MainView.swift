//
//  ContentView.swift
//  MVI
//
//  Created by Константин Савялов on 05.02.2024.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @State private var goesToDetail: Bool = false
    
    var body: some View { content }
}

#Preview {
    MainView(viewModel: MainViewModel(text: "Text", changeValue: ""))
}
