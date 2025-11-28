import SwiftUI
import MapKit

struct ContentView: View {
    // ViewModelを所有
    @StateObject private var viewModel = MapViewModel()
    
    // ログアウト処理用
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            // MARK: - 地図表示 (iOS 17+)
            Map(position: $viewModel.cameraPosition) {
                // 現在地マーカー（青い丸）を表示
                UserAnnotation()
                
                // 軌跡（ポリライン）を表示
                if !viewModel.pathCoordinates.isEmpty {
                    MapPolyline(coordinates: viewModel.pathCoordinates)
                        .stroke(.blue, lineWidth: 5)
                }
            }
            // 地図上の標準コントロールを表示
            .mapControls {
                MapUserLocationButton() // 現在地に戻るボタン
                MapCompass()            // コンパス
                MapScaleView()          // 縮尺
            }
            .onAppear {
                viewModel.onAppear()
            }
            
            // MARK: - 操作UIオーバーレイ
            VStack {
                Spacer()
                
                HStack {
                    // ログアウトボタン（左下）
                    Button(action: {
                        try? AuthService.shared.signOut()
                        // AppStateが検知してStartViewへ遷移します
                    }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.system(size: 20, weight: .bold))
                            .padding()
                            .background(.thinMaterial) // 半透明の背景
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    
                    Spacer()
                    
                    // 計測開始/停止ボタン（中央下）
                    Button(action: {
                        viewModel.toggleTracking()
                    }) {
                        Text(viewModel.isTracking ? "STOP" : "START")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 40)
                            .background(viewModel.isTracking ? Color.red : Color.blue)
                            .cornerRadius(30)
                            .shadow(radius: 5)
                    }
                    
                    Spacer()
                    
                    // バランス用のダミービュー（左のボタンと同じサイズ）
                    Color.clear
                        .frame(width: 50, height: 50)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
