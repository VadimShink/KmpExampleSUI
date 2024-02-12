import SwiftUI
import Shared


struct ContentView2 : View {
    var body: some View {
        VStack {
            Text("Экран 2")
        }
    }
}

struct ContentView: View {
    
    @ObservedObject private var viewModel = FirstScreenViewModel()

    var body: some View {
        ZStack {
            
            VStack(alignment: HorizontalAlignment.center, spacing: 20) {
                
                NavigationLink(destination: ContentView2(), isActive: $viewModel.isLinkActive) {}
   
                if viewModel.uiState.isSending {
                    Text("Отправка данных..")
                } else {
                    Button("Навигация на новый экран") {
                        withAnimation {
                            viewModel.dispatch(action: FirstScreenAction.OnNavigateToNext())
                        }
                    }
                }

                Button("Кнопка") {
                    withAnimation {
                        viewModel.dispatch(action: FirstScreenAction.OnClick())
                    }
                }
                
                VStack(spacing: 16) {
                    
                    if (viewModel.uiState.isError) {
                        Text("Ошибка")
                    } else if (viewModel.uiState.isLoading) {
                        Text("Загрузка \(viewModel.uiState.counter) секунды..")
                    } else {
                        Text("\(viewModel.uiState.data)")
                    }
                    
                    if !viewModel.uiState.isLoading && !viewModel.uiState.isError {
                        Image(systemName: "swift")
                            .font(.system(size: 200))
                            .foregroundColor(.accentColor)
                        
                        Button("Показать селектор") {
                            withAnimation {
                                viewModel.dispatch(action: FirstScreenAction.OnChangeStateSelector(isShow: true))
                            }
                        }
                    }
                }
                .transition(.move(edge: .top).combined(with: .opacity))
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .actionSheet(isPresented: $viewModel.showConfirmationDialog) {
                ActionSheet(
                    title: Text("Пример ActionSheet"),
                    buttons: [
                        .default(Text("Кнопка 1")) {},
                        .default(Text("Кнопка 2")) {},
                        .cancel(Text("Отмена")) {},
                    ]
                )
            }
        }
    }
}

class FirstScreenViewModel : ViewModelWrapper<FirstScreenState, FirstScreenAction, FirstScreenSideEffect> {
    
    @Published var uiState: FirstScreenState =
        .init(isLoading: true,
              isError: false,
              isSending: false,
              data: "",
              counter: 2)
    
    @Published var showConfirmationDialog = false
    @Published var isLinkActive: Bool = false
    
    
    init() {
        super.init(store: FirstScreenStore())
        
        //TODO Включить в кодогенерацию KMPToSwift
        Task { await stateUpdater() }
        
        //TODO Включить в кодогенерацию KMPToSwift
        Task { await sideEffectUpdater() }
    }
    
    //TODO Включить в кодогенерацию KMPToSwift
    @MainActor
    func stateUpdater() async {
        for await state in store.container.stateFlow {
            self.uiState = state as! FirstScreenState
        }
    }
    
    //TODO Включить в кодогенерацию KMPToSwift (прокинуть вызов сайд эффектов)
    @MainActor
    func sideEffectUpdater() async {
        for await sideEffect in store.container.sideEffectFlow {
            
            let effect = sideEffect as! FirstScreenSideEffect
            
            switch onEnum(of: effect) {
                
            case .onError:
                print("Ошибочка вышла!")
                
            case .onChangedStateSelector(let effect):
                showConfirmationDialog = effect.isShow
                
            case .onNavigateToNext:
                isLinkActive.toggle()
                
            }
        }
    }
}
