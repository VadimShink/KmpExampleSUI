//
//  MainViewBuilder.swift
//  MVI
//
//  Created by Константин Савялов on 05.02.2024.
//

import SwiftUI

// MARK - Content ViewBuilder
extension MainView {
    
    @ViewBuilder
    var content: some View {
        
        NavigationView {
            
            VStack(spacing: 50) {
                
                Text(viewModel.text)
                    .font(.largeTitle)
                
                TextField("", text: $viewModel.changeValue, prompt: Text("Password").foregroundStyle(.secondary))
                    .onChange(of: viewModel.changeValue, initial: true) {
                        // Action - Display Password
                        viewModel.action.send(MainViewModel.MainViewModelAction.ChangeTextFieldValue(text: viewModel.changeValue))
                    }
                    .textFieldStyle(.roundedBorder)
                
                NavigationLink(destination: SecondView()) {
                    Text(viewModel.buttonText)
                        .font(.callout)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 20)
                    
                }.buttonStyle(MyButtonStyle())
                    .padding(.top, 50)
            }
        }.padding()
    }
}
