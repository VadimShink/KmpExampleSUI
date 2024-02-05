//
//  MainViewModel.swift
//  MVI
//
//  Created by Константин Савялов on 05.02.2024.
//

import Foundation
import Combine

// MARK - Add RootStateModel
// Intent
class MainViewModel: ObservableObject, RootStateModel {
    
    let action: PassthroughSubject<Action, Never> = .init()
    var bindings = Set<AnyCancellable>()
    
    @Published var text: String
    @Published var changeValue: String
    @Published var buttonText: String = "Go next View"
    
    internal init(text: String, changeValue: String) {
        self.text = text
        self.changeValue = changeValue
        
        bind()
    }
}

// MARK - Add RootDisplayModel
extension MainViewModel: RootDisplayModel {
    
    func changePasswordDisplay(_ text: String) { self.text = text }
    
    func changedTextFieldValue(_ text: String) { action.send(MainViewModel.MainViewModelAction.ChangePasswordDisplay(text: text)) }
}
