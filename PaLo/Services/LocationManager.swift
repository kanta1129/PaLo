import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    // 最新の位置情報をViewModelに渡すためのパブリッシャー
    @Published var lastLocation: CLLocation?
    
    override init() {
        super.init()
        manager.delegate = self
        
        // 設定: 精度や更新頻度
        manager.desiredAccuracy = kCLLocationAccuracyBest // 最高精度
        manager.distanceFilter = 10 // 10メートル移動するごとに更新
        manager.allowsBackgroundLocationUpdates = true // バックグラウンド更新を許可
        manager.pausesLocationUpdatesAutomatically = false // 自動停止を無効化
    }
    
    // 許可リクエスト（画面表示時に呼ぶ）
    func requestPermission() {
        manager.requestAlwaysAuthorization()
    }
    
    // 計測開始
    func start() {
        manager.startUpdatingLocation()
    }
    
    // 計測停止
    func stop() {
        manager.stopUpdatingLocation()
    }
    
    // MARK: - Delegate Methods
    // 位置情報が更新されたら呼ばれる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location // ここを更新するとViewModelに伝わる
    }
    
    // 権限状態が変わった時のログ
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location Access Granted")
        case .denied, .restricted:
            print("Location Access Denied")
        case .notDetermined:
            print("Location Access Not Determined")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error: \(error.localizedDescription)")
    }
}
