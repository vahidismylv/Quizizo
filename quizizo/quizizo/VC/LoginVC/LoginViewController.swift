//
//  ViewController.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 28.09.25.
//

import AuthenticationServices
import GoogleSignIn
import UIKit

class LoginViewController: BaseViewController {
   
    private var appLogo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        return logo
    }()
    
    private var googleLoginButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "Vector"), for: .normal)
        btn.setTitle( "  Continue with Google", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
        return btn
    }()
    
    private var appleLoginButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "Vector 1"),for: .normal)
        btn.setTitle( "  Continue with Apple", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.masksToBounds = true
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(handleAppleSignIn), for: .touchUpInside)
        return btn
    }()
    
    private var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 20
        return sv
    }()
    
    private var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let act = UIActivityIndicatorView()
        act.translatesAutoresizingMaskIntoConstraints = false
        return act
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        textView.textAlignment = .center
        textView.textContainer.maximumNumberOfLines = 2
    }
    
    private func setupUI() {
        setupLogo()
        setupStackView()
        setupText()
        setupTextConsraints()
        setupActivityIndicator()
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    private func setupStackView(){
        view.addSubview(stackView)
        stackView.addArrangedSubview(googleLoginButton)
        stackView.addArrangedSubview(appleLoginButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: appLogo.bottomAnchor, constant: 85).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        
        googleLoginButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        googleLoginButton.widthAnchor.constraint(equalToConstant: 315).isActive = true
    }
    
    private func setupLogo() {
        view.addSubview(appLogo)
        appLogo.translatesAutoresizingMaskIntoConstraints = false
        appLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 94).isActive = true
        appLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appLogo.heightAnchor.constraint(equalToConstant: 275).isActive = true
    }
    
    private func setupText() {

        let fullText = "Read the Privacy & Policy and User & Terms before using IQify app"
        let attributedString = NSMutableAttributedString(string: fullText)

        attributedString.addAttributes([ .foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 14,weight:   .medium)], range: NSRange(location: 0, length: fullText.count))

        let privacyRange = (fullText as NSString).range(of: "Privacy & Policy")
        attributedString.addAttributes([ .underlineStyle: NSUnderlineStyle.single.rawValue, .link: "https://yoursite.com/privacy", .foregroundColor: UIColor.white], range: privacyRange)

        let termsRange = (fullText as NSString).range(of: "User & Terms")
        attributedString.addAttributes([ .underlineStyle: NSUnderlineStyle.single.rawValue, .link: "https://github.com/vahidismylv", .foregroundColor: UIColor.white], range: termsRange)

        textView.attributedText = attributedString
        textView.linkTextAttributes = [.foregroundColor: UIColor.white, .underlineStyle: NSUnderlineStyle.single.rawValue]
    }
    
    private func setupTextConsraints() {
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 62).isActive = true
    }
    
   @objc private func navigateToMain() {
        let homeVc = TabBarController()
        homeVc.modalPresentationStyle = .fullScreen
        present(homeVc, animated: true)
    }
    
    @objc private func handleGoogleSignIn() {
        activityIndicator.startAnimating()
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            if let error = error {
                self.activityIndicator.stopAnimating()
                print("error: \(error.localizedDescription)")
                return
            }
        
            guard let user = result?.user,
                  let idtoken = user.idToken?.tokenString else {
                self.activityIndicator.stopAnimating()
                print("No id token found")
                return
            }
            
            let countryCode = Locale.current.region?.identifier ?? "US"
            
            print("Successfully signed in with Google")
            print("Id: \(idtoken)")
            self.navigateToMain()
            
            self.loginToServer(provider: "google", idToken: idtoken, country: countryCode)
        }
    }
    
    private func loginToServer(provider: String, idToken: String, country: String) {
        print("\n🔵 Login to server başladı")
        NetworkManager.shared.baseURL = "https://api.quizizo.com/"
            
        let requestBody = Login(
            provider: provider,
            idToken: idToken,
            country: country
            )
               
        print("📦 Request Body:")
        print("   Provider: \(provider)")
        print("   Country: \(country)")
        print("   Token length: \(idToken.count)")
               
        NetworkManager.shared.request(
            url: "auth/login",
            method: .POST,
            body: requestBody,  // Login obyekti - NetworkManager özü encode edəcək
                completion: { [weak self] (result: Result<LoginResponse, NetworkError>) in
                    print("\n🔵 Completion handler çağırıldı!")
                    self?.activityIndicator.stopAnimating()

                    switch result {
                    case .success(let response):
                        print("✅✅✅ LOGIN UĞURLU!")
                        print("🎫 Token: \(response.data.token)")
                           
                        UserDefaults.standard.set(response.data.token, forKey: "authToken")
                        KeychainManager.shared.save(response.data.token, forKey: "authToken")
                        
                        KeychainManager.shared.save(response.data.user.name, forKey: "userName")
                        
                        NetworkManager.shared.commonHeaders["Authorization"] = "Bearer \(response.data.token)"
                           
                        self?.navigateToMain()
                           
                       case .failure(let error):
                           print("❌❌❌ LOGIN UĞURSUZ!")
                           print("Error: \(error.localizedDescription)")
                           self?.showError(error.localizedDescription)
                       }
                   }
               )
               
               print("🏃 Request göndərildi, gözləyirik...")
           }
    
    @objc private func handleAppleSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
   
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            if let tokenData = credential.identityToken,
               let idToken = String(data: tokenData, encoding: .utf8) {
                print("Successfully logged in with Apple!")
                print("idToken:\n\(idToken)")
                let country = Locale.current.region?.identifier ?? "US"
                loginToServer(provider: "apple", idToken: idToken, country: country)
            } else {
                print("No idToken")
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error Apple Sign-In: \(error.localizedDescription)")
    }
}



