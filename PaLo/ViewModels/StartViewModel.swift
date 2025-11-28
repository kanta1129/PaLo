import Foundation
import FirebaseAuth // エラー型を扱うために必要

@MainActor // UIに関わる更新をするためMainActorを指定
class StartViewModel: ObservableObject {
    // 画面と同期する変数（Viewで$をつけてバインディングするもの）
    @Published var email = ""
    @Published var password = ""
    @Published var isRegistering = false // 登録モードかどうか
    
    // エラー表示用
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    // ローディング表示用（ボタン連打防止など）
    @Published var isLoading = false
    
    private let authService = AuthService.shared
    
    // ボタンが押された時の処理
    func handleButtonAction() {
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = "メールアドレスとパスワードを入力してください．"
            showingAlert = true
            return
        }
        
        isLoading = true
        
        Task {
            do {
                if isRegistering {
                    try await authService.signUp(email: email, password: password)
                    print("Sign Up Success")
                } else {
                    try await authService.signIn(email: email, password: password)
                    print("Sign In Success")
                }
                // 成功時はAppStateがAuth状態を検知して画面遷移するため，ここでは特別な処理は不要
                
            } catch {
                // エラー発生時
                alertMessage = error.localizedDescription
                showingAlert = true
            }
            
            isLoading = false
        }
    }
    
    // モード切り替え時のリセット処理
    func toggleMode() {
        isRegistering.toggle()
        alertMessage = ""
        showingAlert = false
    }
}
