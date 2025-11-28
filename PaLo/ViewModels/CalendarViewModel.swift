import Foundation
import Combine

class CalendarViewModel: ObservableObject {
    // 選択された日付（初期値は今日）
    @Published var selectedDate: Date = Date()
    
    // 今後，Firestoreからその日のデータを取得する機能などをここに追加します
    
    // 日付が変わった時に呼ばれる処理（デバッグ用）
    func onDateSelected(_ date: Date) {
        print("選択された日付: \(date)")
        // ここでデータの再取得などを行う
    }
}
