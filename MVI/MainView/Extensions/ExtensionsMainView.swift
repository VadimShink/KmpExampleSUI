//
//  ExtensionsMainView.swift
//  MVI
//
//  Created by Константин Савялов on 05.02.2024.
//

import SwiftUI

// MARK - Custom Button Style
extension MainView {
    
    struct MyButtonStyle: ButtonStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            
            configuration.label
                .font(.title)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 5))
        }
    }
}
