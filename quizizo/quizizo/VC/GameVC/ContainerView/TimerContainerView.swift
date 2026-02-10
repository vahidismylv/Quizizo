//
//  ClockContainerView.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 09.10.25.
//

import UIKit

class TimerContainerView: UIView {
    
    private var timer: Timer?
    private var initialTime: Int = 60
    private var timeRemaining: Int = 60
    private var onTimerFinished: (() -> Void)?
    
    private let clockIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "secondClock")
        return icon
    }()
    
    private let timerLabel: UILabel = {
        let txt = UILabel()
        txt.font = .systemFont(ofSize: 30, weight: .bold)
        txt.textColor = .white
        txt.textAlignment = .center
        return txt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        backgroundColor = UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0)
        setupViews()
        setupUI()
        updateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(clockIcon)
        addSubview(timerLabel)
    }
    
    private func setupUI() {
        clockIcon.translatesAutoresizingMaskIntoConstraints = false
        clockIcon.topAnchor.constraint(equalTo: topAnchor, constant: 9).isActive = true
        clockIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        clockIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        clockIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        timerLabel.leadingAnchor.constraint(equalTo: clockIcon.trailingAnchor, constant: 7).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
    
    
    func startTimer() {
        stopTimer()
        timeRemaining = initialTime
        updateLabel()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        timeRemaining = initialTime
        updateLabel()
    }
    
    private func tick() {
        timeRemaining -= 1
        updateLabel()
        
        if timeRemaining <= 0 {
            stopTimer()
            onTimerFinished?()
        }
    }
    
    private func updateLabel() {
        timerLabel.text = TimerContainerView.formatTime(seconds: timeRemaining)
    }
    
    
    func getElapsedTime() -> Int {
        return initialTime - timeRemaining
    }
    
    func getRemainingTime() -> Int {
        return timeRemaining
    }
    
    static func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
    
    func updateLabelAfterStop() {
        timerLabel.text = TimerContainerView.formatTime(seconds: timeRemaining)
    }
    
    func setOnTimerFinished(_ handler: @escaping () -> Void) {
        self.onTimerFinished = handler
    }
    
    deinit {
        stopTimer()
    }
}
