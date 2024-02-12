import SwiftUI
import Shared

class ViewModelWrapper<State: KmpState, Action: KmpAction, SideEffect: KmpSideEffect> : ObservableObject {
    
    var store: MviStore<State, Action, SideEffect>
    
    init(store: MviStore<State, Action, SideEffect>) {
        self.store = store
    }
    
    func dispatch(action: Action) {
        store.dispatch(action: action)
    }
}
