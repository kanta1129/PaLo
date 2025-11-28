import SwiftUI

struct CalendarView: View {
    @StateObject private var viewModel = CalendarViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: - カレンダー表示
                DatePicker(
                    "日付を選択",
                    selection: $viewModel.selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical) // カレンダー形式で表示
                .padding()
                .onChange(of: viewModel.selectedDate) { newDate in
                    viewModel.onDateSelected(newDate)
                }
                
                Divider()
                
                // MARK: - 選択した日の情報（プレースホルダー）
                VStack(spacing: 20) {
                    Text("選択中: \(formattedDate(viewModel.selectedDate))")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    if Calendar.current.isDateInToday(viewModel.selectedDate) {
                        Text("今日の記録が表示されます")
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                    } else {
                        Text("過去の記録データがここに表示されます")
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                .padding(.top)
            }
            .navigationTitle("カレンダー")
        }
    }
    
    // 日付を見やすくフォーマットする関数
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

#Preview {
    CalendarView()
}
