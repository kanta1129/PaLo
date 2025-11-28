//
//  PaLoApp.swift
//  PaLo
//
//  Created by 藤井幹太 on 2025/11/27.


import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct PaLoApp: App {
    
    @StateObject private var appState = AppState()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if appState.isAuthenticated {
                TabView {
                    ContentView()
                        .tabItem { Label("マップ", systemImage: "map.fill") }
                    TimelineView()
                        .tabItem { Label("タイムライン", systemImage: "clock.fill") }
                    CalendarView()
                        .tabItem { Label("カレンダー", systemImage: "calendar") }
                    SettingView()
                        .tabItem { Label("設定", systemImage: "gearshape.fill") }
                }
            } else {
                // 未ログインならスタート画面（StartView）へ
                StartView()
            }

            }
            .environmentObject(appState)
        }
    }
