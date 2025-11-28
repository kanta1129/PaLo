import Foundation
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    
    func signUp(email: String, password: String) async throws -> AuthDataResult{
        return try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func signIn(email: String, password: String) async throws -> AuthDataResult{
        return try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func siginOut() throws {
        try Auth.auth().signOut()
    }
}
