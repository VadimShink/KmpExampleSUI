package mvi

import dev.icerock.moko.mvvm.viewmodel.ViewModel
import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.IO
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.orbitmvi.orbit.ContainerHost
import org.orbitmvi.orbit.annotation.OrbitDsl
import org.orbitmvi.orbit.container
import kotlin.coroutines.CoroutineContext

interface KmpState
interface KmpAction
interface KmpSideEffect

interface IMviStore<STATE : KmpState, ACTION : KmpAction, SIDE_EFFECT : KmpSideEffect> : ContainerHost<STATE, SIDE_EFFECT> {
    fun dispatch(action: ACTION)
}

abstract class MviStore<STATE : KmpState, ACTION : KmpAction, SIDE_EFFECT : KmpSideEffect>(
    state: STATE,
) : ViewModel(), IMviStore<STATE, ACTION, SIDE_EFFECT> {

    override val container = viewModelScope.container<STATE, SIDE_EFFECT>(initialState = state)

    fun onDestroy() {
        onCleared()
    }
}

@OrbitDsl
suspend fun launch(
    ceh: CoroutineExceptionHandler? = null,
    context: CoroutineContext = Dispatchers.IO,
    block: suspend () -> Unit,
) {
    coroutineScope {
        launch(context) {
            try {
                block.invoke()
            } catch (exception: Throwable) {
                withContext(Dispatchers.Main) {
                    ceh?.handleException(coroutineContext, exception)
                }
            }
        }
    }
}