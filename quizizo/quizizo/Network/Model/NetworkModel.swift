//
//  NetworkModel.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 21.10.25.
//

import UIKit
import Foundation

// MARK: - HTTP Method
enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
}

// MARK: - Network Error
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case encodingError(Error)
    case networkError(Error)
    case invalidResponse
    case serverError(Int)
    case unauthorized
    case timeout
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Yanlış URL"
        case .noData:
            return "Məlumat yoxdur"
        case .decodingError(let error):
            return "JSON parse xətası: \(error.localizedDescription)"
        case .encodingError(let error):
            return "JSON encode xətası: \(error.localizedDescription)"
        case .networkError(let error):
            return "Şəbəkə xətası: \(error.localizedDescription)"
        case .invalidResponse:
            return "Yanlış cavab"
        case .serverError(let code):
            return "Server xətası: \(code)"
        case .unauthorized:
            return "Giriş icazəsi yoxdur"
        case .timeout:
            return "Vaxt bitdi"
        }
    }
}

// MARK: - Network Response
struct NetworkResponse {
    let data: Data
    let statusCode: Int
    let headers: [AnyHashable: Any]
}

// MARK: - Image Upload Config
struct ImageUploadConfig {
    let image: UIImage
    let fieldName: String
    let fileName: String
    let mimeType: String
    
    init(image: UIImage, fieldName: String = "image", fileName: String = "image.jpg", mimeType: String = "image/jpeg") {
        self.image = image
        self.fieldName = fieldName
        self.fileName = fileName
        self.mimeType = mimeType
    }
}

