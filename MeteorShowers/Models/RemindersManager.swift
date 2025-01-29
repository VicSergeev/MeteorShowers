import Foundation
import UserNotifications

final class RemindersManager {
    static let shared = RemindersManager()
    private let userDefaults = UserDefaults.standard
    private let reminderKey = "meteorShowerReminders"
    
    private init() {}
    
    // MARK: - Data Structure
    struct ReminderInfo: Codable {
        let showerName: String
        let peakDate: Date
        let notificationDate: Date
        let identifier: String
    }
    
    // MARK: - Public Methods
    func saveReminder(for shower: MeteorShower) {
        let identifier = "meteorShower-\(shower.name)"
        let notificationDate = Calendar.current.date(byAdding: .day, value: -3, to: shower.datePeak)!
        
        let reminderInfo = ReminderInfo(
            showerName: shower.name,
            peakDate: shower.datePeak,
            notificationDate: notificationDate,
            identifier: identifier
        )
        
        var reminders = getAllReminders()
        reminders.append(reminderInfo)
        saveReminders(reminders)
    }
    
    func removeReminder(for shower: MeteorShower) {
        let identifier = "meteorShower-\(shower.name)"
        var reminders = getAllReminders()
        reminders.removeAll { $0.identifier == identifier }
        saveReminders(reminders)
        
        // Also remove from notification center
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    func hasReminder(for shower: MeteorShower) -> Bool {
        let reminders = getAllReminders()
        return reminders.contains { $0.showerName == shower.name }
    }
    
    func restoreAllReminders() {
        let reminders = getAllReminders()
        
        for reminder in reminders {
            // Skip if notification date is in the past
            if reminder.notificationDate < Date() {
                continue
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Upcoming Meteor Shower!"
            content.body = "\(reminder.showerName) meteor shower peaks in 3 days! Get ready for the show!"
            content.sound = .default
            
            let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminder.notificationDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            let request = UNNotificationRequest(
                identifier: reminder.identifier,
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error restoring notification: \(error)")
                }
            }
        }
    }
    
    // MARK: - Private Methods
    private func getAllReminders() -> [ReminderInfo] {
        guard let data = userDefaults.data(forKey: reminderKey),
              let reminders = try? JSONDecoder().decode([ReminderInfo].self, from: data) else {
            return []
        }
        return reminders
    }
    
    private func saveReminders(_ reminders: [ReminderInfo]) {
        guard let data = try? JSONEncoder().encode(reminders) else { return }
        userDefaults.set(data, forKey: reminderKey)
    }
}
