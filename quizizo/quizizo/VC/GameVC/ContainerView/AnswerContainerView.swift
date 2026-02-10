//
//  AnswerContainerView.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 09.10.25.
//

import UIKit

class AnswerContainerView: UIView {
    
    var onAnswerSelected: ((Answer) -> Void)?
    var onTextAnswerSubmitted: ((String) -> Void)?
    private var isLocked = false
    
    private var answers: [Answer] = []
    private var buttons: [UIButton] = []
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 13
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let textField: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16, weight: .medium)
        tv.backgroundColor = UIColor(red: 242/255, green: 238/255, blue: 250/255, alpha: 1.0)
        tv.layer.cornerRadius = 20
        tv.textContainerInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        tv.text = "Write..."
        tv.textColor = .lightGray
        tv.isHidden = true
        return tv
    }()
    
    private let sendButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Send", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(named: "appColor")
        btn.layer.cornerRadius = 20
        btn.isHidden = true
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stackView)
        addSubview(textField)
        addSubview(sendButton)
    }
    
    private func setupUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 199).isActive = true
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true
        sendButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        sendButton.addTarget(self, action: #selector(submitTextAnswer), for: .touchUpInside)
        textField.delegate = self

    }
    
    func configure(with answers: [Answer]) {
        textField.isHidden = true
        sendButton.isHidden = true
        stackView.isHidden = false
        self.answers = answers
        
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        let labels = ["", "", "", "", ""]
        
        for (index, answer) in answers.enumerated() {
            let button = createAnswerButton(
                label: index < labels.count ? labels[index] : "\(index + 1))",
                text: answer.text
            )
            button.tag = index
            button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
            
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    
    func configureTextInput() {
        stackView.isHidden = true
        textField.isHidden = false
        sendButton.isHidden = false
        textField.text = ""
        
        sendButton.isEnabled = false
        sendButton.backgroundColor = .lightGray
    }
    
    private func createAnswerButton(label: String, text: String) -> UIButton {
        let btn = UIButton()
        btn.setTitle("\(label) \(text)", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        btn.titleLabel?.numberOfLines = 0
        btn.contentHorizontalAlignment = .left
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 25
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(named: "appColor")?.cgColor
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return btn
    }
    
    @objc private func answerTapped(_ sender: UIButton) {
        
        guard !isLocked else { return }
        isLocked = true

        let selectedAnswer = answers[sender.tag]
        
        buttons.forEach { $0.backgroundColor = .white }
        sender.backgroundColor = UIColor(named: "appColor")
        sender.setTitleColor(.white, for: .normal)
        
        onAnswerSelected?(selectedAnswer)
    }
    
    @objc private func submitTextAnswer() {
        guard let text = textField.text, !text.isEmpty, text != "Write..." else {
            return
        }
        onTextAnswerSubmitted?(text)
        textField.resignFirstResponder()
    }
    
    func unlockAnswers() {
        isLocked = false
        buttons.forEach { button in
            button.backgroundColor = .white 
            button.isEnabled = true
        }
    }
}

extension AnswerContainerView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write..." {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write..."
            textView.textColor = .lightGray
        }
        updateSendButtonState()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateSendButtonState()
    }
    
    private func updateSendButtonState() {
        let hasText = !textField.text.isEmpty && textField.text != "Write..."
        
        if hasText {
            sendButton.isEnabled = true
            sendButton.backgroundColor = UIColor(named: "appColor")
        } else {
            sendButton.isEnabled = false
            sendButton.backgroundColor = .lightGray
        }
    }
}


