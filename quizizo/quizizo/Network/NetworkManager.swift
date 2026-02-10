//
//  NetworkManager.swift
//  quizizo
//
//  Fixed version - NO RECURSIVE ENCODING!
//

import UIKit
import Foundation


// MARK: - Network Manager
class NetworkManager {
    
    // MARK: - Singleton
    static let shared = NetworkManager()
    
    // MARK: - Properties
    private let session: URLSession
    var baseURL: String = ""
    
    var commonHeaders: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Device-Type": "iOS",
        "iOS-version": UIDevice.current.systemVersion
    ]
    
    // MARK: - Init
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30.0
        config.timeoutIntervalForResource = 60.0
        config.waitsForConnectivity = true
        self.session = URLSession(configuration: config)
    }
    
    // MARK: - Request with Encodable Body (PUBLIC API)
    func request<T: Decodable, U: Encodable>(
        url: String,
        method: HTTPMethod,
        body: U,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        print("\n🔵 NetworkManager.request (Encodable body) başladı")
        print("📍 URL: \(url)")
        print("📍 Method: \(method.rawValue)")
        
        // Encode body to JSON
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(body)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("📦 Encoded Body: \(jsonString)")
            } else {
                print("📦 Body size: \(jsonData.count) bytes")
            }
            
            // Call internal method with Data
            performRequest(
                url: url,
                method: method,
                bodyData: jsonData,
                headers: headers,
                responseType: T.self,
                completion: completion
            )
        } catch {
            print("❌ Encoding Error: \(error)")
            DispatchQueue.main.async {
                completion(.failure(.encodingError(error)))
            }
        }
    }
    
    // MARK: - Request without Body (for GET)
    func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .GET,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        print("\n🟢 NetworkManager.request (NO body) başladı")
        print("📍 URL: \(url)")
        print("📍 Method: \(method.rawValue)")
        
        performRequest(
            url: url,
            method: method,
            bodyData: nil,
            headers: headers,
            responseType: T.self,
            completion: completion
        )
    }
    
    
    // MARK: - Internal Request Performer
    private func performRequest<T: Decodable>(
        url: String,
        method: HTTPMethod,
        bodyData: Data?,
        headers: [String: String]?,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        print("\n🚀 Sorğu hazırlanır...")
        
        // Full URL yaradırıq
        let fullURL = baseURL + url
        print("📍 Full URL: \(fullURL)")
        
        guard let requestURL = URL(string: fullURL) else {
            print("❌ Invalid URL: \(fullURL)")
            DispatchQueue.main.async {
                completion(.failure(.invalidURL))
            }
            return
        }
        
        // URLRequest yaradırıq
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 30.0
        
        // Common headers əlavə edirik
        for (key, value) in commonHeaders {
            urlRequest.setValue(value, forHTTPHeaderField: key)
            print("📋 Header: \(key) = \(value)")
        }
        
        // Custom headers əlavə edirik
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
                print("📋 Custom Header: \(key) = \(value)")
            }
        }
        
        // Body əlavə edirik
        if let bodyData = bodyData {
            urlRequest.httpBody = bodyData
            print("📦 Body attached: \(bodyData.count) bytes")
        }
        
        print("🚀 URLSession.dataTask başlayır...")
        
        // Request göndəririk
        let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            print("\n✅ Cavab alındı!")
            
            // Error check
            if let error = error {
                print("❌ Network Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(.networkError(error)))
                }
                return
            }
            
            // Response check
            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ Invalid Response (not HTTP)")
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            print("📊 Status Code: \(httpResponse.statusCode)")
            
            // Status code check
            guard (200...299).contains(httpResponse.statusCode) else {
                print("❌ Server Error: \(httpResponse.statusCode)")
                
                // Print response body for debugging
                if let data = data, let errorString = String(data: data, encoding: .utf8) {
                    print("📥 Error Response: \(errorString)")
                }
                
                DispatchQueue.main.async {
                    completion(.failure(.serverError(httpResponse.statusCode)))
                }
                return
            }
            
            // Data check
            guard let data = data else {
                print("❌ No Data in response")
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            print("📥 Response data received: \(data.count) bytes")
            if let responseString = String(data: data, encoding: .utf8) {
                print("📥 Response body: \(responseString)")
            }
            
            // JSON Decode
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                print("✅✅✅ JSON decode UĞURLU!")
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                print("❌ Decoding Error: \(error)")
                if let decodingError = error as? DecodingError {
                    self?.printDecodingError(decodingError)
                }
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        task.resume()
        print("🏃 Task.resume() çağırıldı - sorğu göndərildi!")
    }
    
    // MARK: - Image Download
    func downloadImage(
        from urlString: String,
        completion: @escaping (Result<UIImage, NetworkError>) -> Void
    ) {
        // Если urlString уже абсолютный — используем его, иначе добавляем baseURL
        let fullString: String
        if urlString.lowercased().hasPrefix("http") {
            fullString = urlString
        } else {
            fullString = baseURL + urlString
        }

        guard let imageURL = URL(string: fullString) else {
            DispatchQueue.main.async { completion(.failure(.invalidURL)) }
            return
        }

        // Попробуем кеш (URLCache стандартный) — быстрое улучшение
        let request = URLRequest(url: imageURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(.networkError(error))) }
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async { completion(.failure(.noData)) }
                return
            }
            DispatchQueue.main.async { completion(.success(image)) }
        }
        task.resume()
    }
    
    // MARK: - Image Upload
    func uploadImage<T: Decodable>(
        to url: String,
        config: ImageUploadConfig,
        additionalFields: [String: String]? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let fullURL = baseURL + url
        
        guard let uploadURL = URL(string: fullURL) else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL))
            }
            return
        }
        
        let boundary = "Boundary-\(UUID().uuidString)"
        let body = createMultipartBody(
            config: config,
            additionalFields: additionalFields,
            boundary: boundary
        )
        
        var request = URLRequest(url: uploadURL)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Add custom headers
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        request.httpBody = body
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.networkError(error)))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(.serverError(httpResponse.statusCode)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        task.resume()
    }
    
    // MARK: - Helper Methods
    private func createMultipartBody(
        config: ImageUploadConfig,
        additionalFields: [String: String]?,
        boundary: String
    ) -> Data {
        var body = Data()
        
        // Add additional fields
        if let fields = additionalFields {
            for (key, value) in fields {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }
        }
        
        // Add image
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(config.fieldName)\"; filename=\"\(config.fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(config.mimeType)\r\n\r\n".data(using: .utf8)!)
        
        if let imageData = config.image.jpegData(compressionQuality: 0.8) {
            body.append(imageData)
        }
        
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
    
    private func printDecodingError(_ error: DecodingError) {
        switch error {
        case .typeMismatch(let type, let context):
            print("❌ Type mismatch: \(type)")
            print("   Context: \(context.debugDescription)")
            print("   Coding path: \(context.codingPath)")
        case .valueNotFound(let type, let context):
            print("❌ Value not found: \(type)")
            print("   Context: \(context.debugDescription)")
            print("   Coding path: \(context.codingPath)")
        case .keyNotFound(let key, let context):
            print("❌ Key not found: \(key)")
            print("   Context: \(context.debugDescription)")
            print("   Coding path: \(context.codingPath)")
        case .dataCorrupted(let context):
            print("❌ Data corrupted")
            print("   Context: \(context.debugDescription)")
            print("   Coding path: \(context.codingPath)")
        @unknown default:
            print("❌ Unknown decoding error: \(error)")
        }
    }
}

