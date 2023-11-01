import Foundation

final class HomeViewModel {

    func getTitle() -> String {
        let now = Date()
        return getDateFormatter(now: now)
    }

    private func getDateFormatter(now: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd 'de' MMMM"
        formatter.locale = Locale(identifier: "pt-BR")
       return formatter.string(from: now)
    }
}
