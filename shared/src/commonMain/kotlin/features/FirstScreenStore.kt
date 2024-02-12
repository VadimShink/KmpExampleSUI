package features

import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.delay
import mvi.KmpAction
import mvi.KmpSideEffect
import mvi.KmpState
import mvi.MviStore
import mvi.launch
import org.orbitmvi.orbit.syntax.simple.intent
import org.orbitmvi.orbit.syntax.simple.postSideEffect
import org.orbitmvi.orbit.syntax.simple.reduce

data class FirstScreenState(
    val isLoading: Boolean = false,
    val isError: Boolean = false,
    val isSending: Boolean = false,
    val data: String = "",
    val counter: Int = 2,
): KmpState

sealed class FirstScreenAction: KmpAction {
    data object OnStart : FirstScreenAction()
    data object OnClick : FirstScreenAction()
    data class OnChangeStateSelector(val isShow: Boolean) : FirstScreenAction()
    data object OnNavigateToNext : FirstScreenAction()
}

sealed class FirstScreenSideEffect: KmpSideEffect {
    data object OnError : FirstScreenSideEffect()
    data class OnChangedStateSelector(val isShow: Boolean) : FirstScreenSideEffect()
    data object OnNavigateToNext : FirstScreenSideEffect()
}

class FirstScreenStore : MviStore<FirstScreenState, FirstScreenAction, FirstScreenSideEffect>(
    state = FirstScreenState()
) {
    private val ceh = CoroutineExceptionHandler { _, e ->
        intent {
            reduce { state.copy(isError = true) }
            postSideEffect(FirstScreenSideEffect.OnError)
        }
    }

    init {
        dispatch(FirstScreenAction.OnStart)
    }

    override fun dispatch(action: FirstScreenAction) {
        when(action) {
            FirstScreenAction.OnClick -> intent {
                if (!state.isError) {
                    launch(ceh) {
                        throw RuntimeException()
                    }
                } else {
                    dispatch(FirstScreenAction.OnStart)
                }
            }
            FirstScreenAction.OnStart -> intent {
                reduce { state.copy(isLoading = true, isError = false) }
                reduce { state.copy(counter = state.counter - 0) }
                delay(1000)
                reduce { state.copy(counter = state.counter - 1) }
                delay(1000)
                reduce { state.copy(isLoading = false, data = "Hello World!", counter = 2) }
            }

            is FirstScreenAction.OnChangeStateSelector -> intent {
                postSideEffect(FirstScreenSideEffect.OnChangedStateSelector(action.isShow))
            }

            FirstScreenAction.OnNavigateToNext -> intent {
                reduce { state.copy(isSending = true) }
                delay(2000)
                reduce { state.copy(isSending = false) }
                postSideEffect(FirstScreenSideEffect.OnNavigateToNext)
            }
        }
    }
}
