import Foundation
import SwiftUI
import MapKit
import CoreLocation
import Combine

class MapViewModel: ObservableObject {
    // 地図のカメラ位置（iOS 17+）: 現在地追従モードを初期値に設定
    @Published var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    // 軌跡を描画するための座標リスト
    @Published var pathCoordinates: [CLLocationCoordinate2D] = []
    
    // 計測中かどうか
    @Published var isTracking = false
    
    // LocationManagerのインスタンスを保持
    private let locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupLocationSubscription()
    }
    
    // 画面表示時に位置情報の許可をリクエスト
    func onAppear() {
        locationManager.requestPermission()
    }
    
    // 計測開始・停止の切り替え
    func toggleTracking() {
        isTracking.toggle()
        if isTracking {
            locationManager.start()
        } else {
            locationManager.stop()
        }
    }
    
    // LocationManagerからの位置情報更新を監視
    private func setupLocationSubscription() {
        locationManager.$lastLocation
            .compactMap { $0 } // nilを除外
            .receive(on: DispatchQueue.main) // UI更新のためメインスレッドで受け取る
            .sink { [weak self] location in
                self?.updateLocation(location)
            }
            .store(in: &cancellables)
    }
    
    // 位置情報が更新された時の処理
    private func updateLocation(_ location: CLLocation) {
        let coordinate = location.coordinate
        
        // 計測中のみ軌跡リストに追加
        if isTracking {
            self.pathCoordinates.append(coordinate)
        }
        
        // 必要であればここでFirestoreへの保存処理などを呼び出す
        print("Updated Location: \(coordinate.latitude), \(coordinate.longitude)")
    }
}
