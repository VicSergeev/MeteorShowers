//
//  ShowerDetailViewController.swift
//  MeteorShowers
//
//  Created by Vic on 29.01.2025.
//

import UIKit
import SnapKit
import UserNotifications

final class ShowerDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let moonPhaseCalculator = MoonPhaseCalculation()
    private var currentShower: MeteorShower?
    private var hasReminder = false
    private lazy var reminderButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "bell.fill"),
            style: .plain,
            target: self,
            action: #selector(reminderButtonTapped)
        )
        button.tintColor = .systemGreen
        return button
    }()
    
    // MARK: - Main stack
    lazy private var mainStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    // MARK: - content stack
    lazy private var topContentStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    lazy private var midContentStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    lazy private var bottomContentStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    lazy private var mainImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "moon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy private var notificationIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "bell.fill")
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(24)
        }
        return imageView
    }()
    
    lazy private var peakLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    lazy private var ZHRLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    lazy private var originLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    lazy private var moonPhaseLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    lazy private var moonPhaseIcon: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "moon")
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    // MARK: - life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .topBg
        setupUI()
        setupNavigationBar()
    }

}

// MARK: - Setup UI
extension ShowerDetailViewController {
    func setupUI() {
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(topContentStackView)
        mainStackView.addArrangedSubview(midContentStackView)
        mainStackView.addArrangedSubview(bottomContentStackView)
        
        topContentStackView.addArrangedSubview(mainImageView)
        midContentStackView.addArrangedSubview(peakLabel)
        midContentStackView.addArrangedSubview(ZHRLabel)
        mainStackView.addArrangedSubview(originLabel)
        bottomContentStackView.addArrangedSubview(moonPhaseLabel)
        bottomContentStackView.addArrangedSubview(moonPhaseIcon)
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        moonPhaseIcon.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = reminderButton
        navigationItem.largeTitleDisplayMode = .never
        updateReminderButtonState()
    }
    
    private func updateReminderButtonState() {
        guard let shower = currentShower else { return }
        
        let identifier = "meteorShower-\(shower.name)"
        UNUserNotificationCenter.current().getPendingNotificationRequests { [weak self] requests in
            let hasReminder = requests.contains { $0.identifier == identifier }
            DispatchQueue.main.async {
                self?.hasReminder = hasReminder
                self?.reminderButton.image = UIImage(systemName: hasReminder ? "bell.slash.fill" : "bell.fill")
            }
        }
    }
    
    @objc private func reminderButtonTapped() {
        if hasReminder {
            removeNotification()
        } else {
            requestNotificationPermission()
        }
    }
    
    private func removeNotification() {
        guard let shower = currentShower else { return }
        
        let identifier = "meteorShower-\(shower.name)"
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        
        // Update UI and show feedback
        hasReminder = false
        reminderButton.image = UIImage(systemName: "bell.fill")
        
        let alert = UIAlertController(
            title: "Reminder Removed",
            message: "The reminder for \(shower.name) meteor shower has been removed.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
            if granted {
                DispatchQueue.main.async {
                    self?.scheduleNotification()
                }
            } else {
                // Handle case when permission is not granted
                print("Notification permission denied")
            }
        }
    }
    
    private func scheduleNotification() {
        guard let shower = currentShower else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Upcoming Meteor Shower!"
        content.body = "\(shower.name) meteor shower peaks in 3 days! Get ready for the show!"
        content.sound = .default
        
        // Calculate notification date (3 days before peak)
        let peakDate = shower.datePeak
        let notificationDate = Calendar.current.date(byAdding: .day, value: -3, to: peakDate)!
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(
            identifier: "meteorShower-\(shower.name)",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error scheduling notification: \(error)")
                    self?.showNotificationAlert(success: false)
                } else {
                    print("Notification scheduled for \(shower.name)")
                    self?.hasReminder = true
                    self?.reminderButton.image = UIImage(systemName: "bell.slash.fill")
                    self?.showNotificationAlert(success: true)
                }
            }
        }
    }
    
    private func showNotificationAlert(success: Bool) {
        let title = success ? "Reminder Set!" : "Error"
        let message = success ? 
            "You'll be notified 3 days before the \(currentShower?.name ?? "") meteor shower peaks." :
            "Failed to set reminder. Please check if notifications are enabled in Settings."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Fill with contents

extension ShowerDetailViewController {
    func configure(with shower: MeteorShower) {
        currentShower = shower
        navigationItem.title = shower.name
        peakLabel.text = "Peak: \(shower.formattedPeakDate)"
        ZHRLabel.text = "\(shower.formattedZHR)"
        originLabel.text = "Parent body: \(shower.parentBodyLabel)"
        
        // Calculate moon phase for shower's peak date
        let moonPhase = moonPhaseCalculator.getMoonPhase(date: shower.datePeak)
        if let phase = MoonPhase(rawValue: moonPhase.phase) {
            moonPhaseIcon.image = phase.icon
            moonPhaseLabel.text = moonPhase.phase
        }
        
        // Check if reminder exists
        updateReminderButtonState()
    }
    
    private func updateMoonPhase() {
        let moonInfo = moonPhaseCalculator.getMoonPhase()
        updateMoonPhaseUI(with: moonInfo)
    }
    
    private func updateMoonPhaseUI(with moonInfo: (phase: String, illumination: Double, age: Double)) {
        moonPhaseLabel.text = moonInfo.phase
    }
}
