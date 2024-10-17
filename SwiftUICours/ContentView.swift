import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack {
            Text("Bienvenue!")
                .font(.largeTitle)
        }
    }
}

#Preview {
    ContentView()
}
