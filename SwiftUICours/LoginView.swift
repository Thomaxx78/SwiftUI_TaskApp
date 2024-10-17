import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var showAlert = false
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack {
            Text("Connexion")
                .font(.largeTitle)
                .padding()
            
            TextField("Nom d'utilisateur", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Mot de passe", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                if authManager.login(username: username, password: password) {
                    
                } else {
                    showAlert = true
                }
            }) {
                Text("Se connecter")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Erreur"), message: Text("Nom d'utilisateur ou mot de passe incorrect"), dismissButton: .default(Text("OK")))
        }
    }
}
