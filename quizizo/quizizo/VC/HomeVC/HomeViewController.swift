//
//  HomeViewController.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 02.10.25.
//

import UIKit

class HomeViewController: BaseViewController {
   
    private var isFirstLoad = true

    private let pointView = HomeContainerView()
    private let averageTimeView = TimeContainerView()
    private let totalTimeView = TimeContainerView()
    private let trueFalseView = TrueFalseContainerView()
    private let playView = PlayContainerView()

    private var nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Vahid"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private var pointLabel: UILabel = {
        let label = UILabel()
        label.text = "XP 1000"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private var coinImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Coin")
        return image
    }()
    
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar") 
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        setupViews()
        setupUI()
        setupContainerView()
        fetchUserData()
        
        playView.onTap = { [weak self] in
            self?.navigateToPlayScreen()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isFirstLoad {
            print("🔄 Refreshing stats after game...")
            refreshStats()
        }
        
        isFirstLoad = false
    }
    
    private func setupViews() {
        view.addSubview(nameLabel)
        view.addSubview(pointLabel)
        view.addSubview(coinImage)
        view.addSubview(avatarImageView)
        view.addSubview(pointView)
        view.addSubview(averageTimeView)
        view.addSubview(totalTimeView)
        view.addSubview(trueFalseView)
        view.addSubview(playView)
    }
    
    private func setupUI() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
        coinImage.translatesAutoresizingMaskIntoConstraints = false
        coinImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        coinImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
        pointLabel.translatesAutoresizingMaskIntoConstraints = false
        pointLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15).isActive = true
        pointLabel.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 5).isActive = true
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 68).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupContainerView() {
        pointView.translatesAutoresizingMaskIntoConstraints = false
        pointView.layer.cornerRadius = 15
        pointView.topAnchor.constraint(equalTo: coinImage.bottomAnchor, constant: 30).isActive = true
        pointView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        pointView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        pointView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        pointView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        
        averageTimeView.backgroundColor = UIColor.white.withAlphaComponent(0.65)
        averageTimeView.translatesAutoresizingMaskIntoConstraints = false
        averageTimeView.configUI(time: "", info: "Average time")
        averageTimeView.topAnchor.constraint(equalTo: pointView.bottomAnchor, constant: 20).isActive = true
        averageTimeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        averageTimeView.heightAnchor.constraint(equalToConstant: 96).isActive = true
        averageTimeView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        totalTimeView.backgroundColor = UIColor.white.withAlphaComponent(0.65)
        totalTimeView.translatesAutoresizingMaskIntoConstraints = false
        totalTimeView.configUI(time: "", info: "Total time")
        totalTimeView.topAnchor.constraint(equalTo: pointView.bottomAnchor, constant: 20).isActive = true
//        totalTimeView.leadingAnchor.constraint(equalTo: averageTimeView.trailingAnchor, constant: 40).isActive = true
        totalTimeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        totalTimeView.heightAnchor.constraint(equalToConstant: 96).isActive = true
        totalTimeView.widthAnchor.constraint(equalToConstant: 155).isActive = true
        
        trueFalseView.translatesAutoresizingMaskIntoConstraints = false
        trueFalseView.layer.cornerRadius = 15
        trueFalseView.topAnchor.constraint(equalTo: averageTimeView.bottomAnchor, constant: 20).isActive = true
        trueFalseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        trueFalseView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        trueFalseView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        trueFalseView.widthAnchor.constraint(equalToConstant: 315).isActive = true
        
        playView.translatesAutoresizingMaskIntoConstraints = false
        playView.topAnchor.constraint(equalTo: trueFalseView.bottomAnchor, constant: 30).isActive = true
        playView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        playView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        playView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        playView.widthAnchor.constraint(equalToConstant: 315).isActive = true
    }
    
    private func fetchUserData() {
        print("🚀 Fetching user/me ...")
        let url = "user/me"

        guard KeychainManager.shared.get(forKey: "authToken") != nil else {
            print("❌ No token in Keychain")
            return
        }
  
        NetworkManager.shared.request(
            url: url,
            method: .GET,
            completion: { [weak self] (result: Result<UserMeResponse, NetworkError>) in
            switch result {
            case .success(let response):
                print("✅ User info received: \(response.data.name)")
                
                DispatchQueue.main.async {
                    self?.nameLabel.text = response.data.name
                    
                    if let urlString = response.data.profilePicture,
                       let url = URL(string: urlString) {
                        self?.loadImage(from: url)
                    } else {
                        self?.avatarImageView.image = UIImage(named: "avatar")
                    }
                }
                
                            
                self?.fetchUserStats(countryCode: response.data.country)

            case .failure(let error):
                print("❌ User info error: \(error.localizedDescription)")
            }
        }
        )
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.avatarImageView.image = image
                }
            }
        }.resume()
    }
    
    private func fetchUserStats(countryCode: String) {
        let url = "user/stats"
        
        NetworkManager.shared.request(
            url: url,
            method: .GET,
            completion: { [weak self] (result: Result<UserStatsResponse, NetworkError>) in
            switch result {
            case .success(let response):
                    let stats = response.data
                    
                    DispatchQueue.main.async {
                        self?.pointLabel.text = "XP \(stats.xp)"
                        self?.pointView.configure(
                                            globalRank: stats.globalRankPosition,
                                            localRank: stats.localRankPosition,
                                            score: stats.score,
                                            countryCode: countryCode
                                        )
                        self?.totalTimeView.configApi(time: stats.totalDuration)
                        self?.averageTimeView.configApi(time: stats.averageDuration)
                        self?.trueFalseView.configApi(correct: stats.correctCount, wrong: stats.wrongCount)
                        
                    }
                        
            case .failure(let error):
                    print("❌ Stats error: \(error.localizedDescription)")
                }
        }
        )
    }
    
    func navigateToPlayScreen() {
        let gameVC = GameViewController()
        navigationController?.pushViewController(gameVC, animated: true)
    }
    
    private func refreshStats() {
        NetworkManager.shared.request(
            url: "user/stats",
            method: .GET,
            completion: { [weak self] (result: Result<UserStatsResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let stats = response.data
                
                DispatchQueue.main.async {
                    self?.pointLabel.text = "XP \(stats.xp)"
                    
                    self?.pointView.configure(
                        globalRank: stats.globalRankPosition,
                        localRank: stats.localRankPosition,
                        score: stats.score, countryCode: ""
                    )
                    
                    self?.totalTimeView.configApi(time: stats.totalDuration)
                    self?.averageTimeView.configApi(time: stats.averageDuration)
                    
                    self?.trueFalseView.configApi(correct: stats.correctCount, wrong: stats.wrongCount)
                    
                    print("✅ Stats refreshed!")
                }
                
            case .failure(let error):
                print("❌ Stats refresh error: \(error.localizedDescription)")
            }
        })
    }
    

    
}

#Preview {
    HomeViewController()
}


