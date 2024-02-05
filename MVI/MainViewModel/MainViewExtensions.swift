//
//  MainViewExtensions.swift
//  MVI
//
//  Created by Константин Савялов on 06.02.2024.
//

import Foundation

// MARK - Binding
extension MainViewModel {
    
    func bind() {
        
        action
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] action in
                
                switch action {
                    
                case let parameter as MainViewModel.MainViewModelAction.ChangeTextFieldValue:
                    changedTextFieldValue(parameter.text)
                    
                case let parameter as MainViewModel.MainViewModelAction.ChangePasswordDisplay:
                    changePasswordDisplay(parameter.text)
                    
                default:
                    break
                }
            }
            .store(in: &bindings)
    }
}

// MARK - Action NameSpace
extension MainViewModel {
    
    enum MainViewModelAction {
        
        struct GoToSecondView: Action {}
        
        struct ChangeTextFieldValue: Action { let text: String }
        
        struct ChangePasswordDisplay: Action { let text: String }
    }
}
