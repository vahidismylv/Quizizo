//
//  GameViewController.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 08.10.25.
//

import UIKit

class GameViewController: UIViewController {
    
    private var currentQuestion: Question?
    private var questionStartTime: Date?
    
    private let timerView = TimerContainerView()
    private let questionView = QuestionView()
    private let answerView = AnswerContainerView()
    private let plusView = PlusContainerView()
    
    private let exitIcon: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor(named: "appColor")
        btn.tintColor = .white
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = false
    
        setupBackground()
        setupViews()
        setupUI()
        
        exitIcon.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        navigationItem.hidesBackButton = true
        
        fetchQuestions()
        
        answerView.onAnswerSelected = { [weak self] answer in
            self?.checkAnswer(answer)
        }
        
        timeFinished()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.bringSubviewToFront(exitIcon)
        view.bringSubviewToFront(plusView)
    }
    
    private func setupViews() {
        view.addSubview(timerView)
        view.addSubview(questionView)
        view.addSubview(answerView)
        view.addSubview(plusView)

        view.addSubview(exitIcon)
        view.addSubview(plusView)
        
    }
    
    private func setupUI() {
        exitIcon.translatesAutoresizingMaskIntoConstraints = false
        exitIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1).isActive = true
        exitIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        exitIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        exitIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        timerView.translatesAutoresizingMaskIntoConstraints = false
        timerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 124).isActive = true
        timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105).isActive = true
        timerView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        timerView.widthAnchor.constraint(equalToConstant: 168).isActive = true
        timerView.layer.cornerRadius = 20
        
        questionView.translatesAutoresizingMaskIntoConstraints = false
        questionView.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 40).isActive = true
        questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        questionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        answerView.translatesAutoresizingMaskIntoConstraints = false
        answerView.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 30).isActive = true
        answerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        answerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    
        plusView.translatesAutoresizingMaskIntoConstraints = false
        plusView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        plusView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        plusView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        plusView.isHidden = true
    }
    
    private func setupBackground() {
        let background = WhiteBackgroundView()
        view.insertSubview(background, at: 0)
        background.isUserInteractionEnabled = false
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func timeFinished() {
        timerView.setOnTimerFinished { [weak self] in
            guard let self = self else { return }
            print("No Answer")
        
            self.showResultPoints(-4, isCorrect: false)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @objc private func closeTapped() {
        print("Closed")
        navigationController?.popViewController(animated: true)
    }
    
    private func fetchQuestions() {
        print("🚀 Fetching question (next)...")

        NetworkManager.shared.request(
            url: "questions/next",
            method: .GET,
            completion: { [weak self] (result: Result<QuestionResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    print("✅ Question loaded: \(response.data.id)")
                    DispatchQueue.main.async {
                        self?.showQuestion(response.data)
                    }

                case .failure(let error):
                    print("❌ Failed to load question: \(error.localizedDescription)")
                }
            }
        )
    }
    
//    private func showQuestion(_ question: Question) {
//        self.currentQuestion = question
//        questionStartTime = Date()
//        
//        let text = question.questionText ?? ""
//        questionView.configure(text: text, image: nil)
//
//        if let imagePath = question.imageUrl, !imagePath.isEmpty {
//            let full = imagePath.hasPrefix("http") ? imagePath : ("https://api.quizizo.com" + imagePath)
//            if let url = URL(string: full) {
//                loadImage(from: url) { [weak self] image in
//                    self?.questionView.configure(text: text, image: image)
//                }
//            }
//        }
//
//        let uiAnswers: [Answer] = question.options.enumerated().map { (idx, option) in
//            return Answer(
//                id: "\(idx)",
//                text: option.text,
//                image: nil,
//                isCorrect: false
//            )
//        }
//        answerView.configure(with: uiAnswers)
//        timerView.startTimer()
//    }
    
    private func showQuestion(_ question: Question) {
        self.currentQuestion = question
        
        let text = question.questionText ?? ""
        questionView.configure(text: text, image: nil)

        if let imagePath = question.imageUrl, !imagePath.isEmpty {
            let full = imagePath.hasPrefix("http") ? imagePath : ("https://api.quizizo.com" + imagePath)
            if let url = URL(string: full) {
                loadImage(from: url) { [weak self] image in
                    self?.questionView.configure(text: text, image: image)
                }
            }
        }

        if question.type == "TEXT_INPUT" {
            answerView.configureTextInput()
            
            answerView.onTextAnswerSubmitted = { [weak self] text in
                self?.checkTextAnswer(text)
            }
        } else {
            let uiAnswers: [Answer] = question.options.enumerated().map { (idx, option) in
                return Answer(
                    id: "\(idx)",
                    text: option.text,
                    image: nil,
                    isCorrect: false
                )
            }
            answerView.configure(with: uiAnswers)
            
            answerView.onAnswerSelected = { [weak self] answer in
                self?.checkAnswer(answer)
            }
        }

        timerView.startTimer()
    }
    
    
    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    
    private func checkAnswer(_ answer: Answer) {
        timerView.stopTimer()
        
        let duration = timerView.getElapsedTime()
        timerView.updateLabelAfterStop()
        submitAnswer(answer, duration: duration)
    }
    
    private func submitAnswer(_ answer: Answer, duration: Int) {
        guard let question = currentQuestion else {
            print("❌ No current question!")
            return
        }
        
        let questionId = question.id
        let selectedIndex = Int(answer.id) ?? 0
        
        let body = SubmitAnswerBody(
            questionId: questionId,
            selectedIndex: selectedIndex,
            duration: duration
        )

        NetworkManager.shared.request(
            url: "questions/answer",
            method: .POST,
            body: body,
            completion: { [weak self] (result: Result<SubmitAnswerResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    print("✅ Ответ отправлен: \(response.data.isCorrect ? "Правильно" : "Неправильно")")

                    DispatchQueue.main.async {
                        self?.showResultPoints(response.data.delta, isCorrect: response.data.isCorrect)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self?.answerView.unlockAnswers()
                        self?.fetchQuestions()
                    }
                    
                case .failure(let error):
                    print("❌ Ошибка при отправке ответа: \(error.localizedDescription)")
                }
            }
        )
    }
    
    private func checkTextAnswer(_ text: String) {
        guard let question = currentQuestion else { return }
        
        timerView.stopTimer()
        
        let body = SubmitTextAnswerBody(
            questionId: question.id,
            answer: text, 
            duration: 1
        )
        
        NetworkManager.shared.request(
            url: "questions/answer",
            method: .POST,
            body: body,
            completion: { [weak self] (result: Result<SubmitAnswerResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self?.showResultPoints(response.data.delta, isCorrect: response.data.isCorrect)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        self?.fetchQuestions()
                    }
                    
                case .failure(let error):
                    print("❌ Ошибка: \(error.localizedDescription)")
                }
            }
        )
    }
    
    
    private func showResultPoints(_ points: Int, isCorrect: Bool) {
        plusView.show(points: points, isCorrect: isCorrect)
    }
    
    
}
