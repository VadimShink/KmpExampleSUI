import SwiftUI

@main
struct iOSApp: App {
    
    @State var isShowMain = false
    
	var body: some Scene {
		WindowGroup {
            NavigationView {
                ContentView()
            }
		}
	}
}
