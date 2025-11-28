import SwiftUI

struct StartView: View {
    // ViewModelを所有する
    @StateObject private var viewModel = StartViewModel()
    
    // AppStateは引き続き必要（画面遷移のトリガーになるため）
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            Spacer()

            // アイコン
            Image(systemName: "location.fill.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.accentColor)
                .padding(.bottom, 20)

            Text("PaLogへようこそ！")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            Text("あなたの行動を自動で記録・分析します．")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 30)

            // MARK: - 入力フォーム (ViewModelの値をバインド)
            Group {
                TextField("メールアドレス", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never) // 推奨される新しい書き方
                    .disableAutocorrection(true)
                    .padding(.horizontal, 30)
                
                SecureField("パスワード", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)
            }
            .padding(.bottom, 10)
            .disabled(viewModel.isLoading) // 処理中は入力を無効化

            // MARK: - ボタン
            Button(action: {
                // ロジックはViewModelに任せる
                viewModel.handleButtonAction()
            }) {
                HStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding(.trailing, 5)
                    }
                    Text(viewModel.isRegistering ? "新規登録" : "ログイン")
                        .fontWeight(.bold)
                }
                .font(.title2)
                .padding()
                .frame(maxWidth: .infinity)
                .background(viewModel.isLoading ? Color.gray : Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding(.horizontal, 30)
            }
            .disabled(viewModel.isLoading) // 連打防止
            .padding(.bottom, 10)

            // MARK: - 切り替えボタン
            Button(action: {
                viewModel.toggleMode()
            }) {
                Text(viewModel.isRegistering ? "すでにアカウントをお持ちですか？ログイン" : "アカウントをお持ちでないですか？新規登録")
                    .font(.caption)
                    .foregroundColor(.accentColor)
            }
            .padding(.bottom, 20)
            .disabled(viewModel.isLoading)

            Spacer()
        }
        // アラートの表示制御もViewModelのプロパティを使う
        .alert("認証エラー", isPresented: $viewModel.showingAlert) {
            Button("OK") { }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}

#Preview {
    StartView()
        .environmentObject(AppState())
}
