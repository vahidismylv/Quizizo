//
//  Model.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 06.10.25.
//

import UIKit

struct Login: Codable {
    let provider: String
    let idToken: String
    let country: String
}


struct LoginResponse: Codable {
    let status: String
    let message: String
    let data: LoginData
}

struct LoginData: Codable {
    let token: String
    let user: User
}

struct User: Codable {
    let id: String
    let email: String
    let name: String
    let country: String
    let profilePicture: String
    let isPremium: Bool
}

struct LeaderboardUser: Codable {
    let userId: String
    let name: String
    let score: Int
    let rank: String
    let rankPosition: Int
    let country: String
    let profilePicture: String?
}

struct LeaderboardData: Codable {
    let userRank: LeaderboardUser
    let leaders: [LeaderboardUser]
}

struct LeaderboardResponse: Codable {
    let status: String
    let message: String
    let data: LeaderboardData
}

struct EmptyBody: Codable {}

struct UserMeResponse: Codable {
    let status: String
    let message: String
    let data: UserMeData
}

struct UserMeData: Codable {
    let id: String
    let email: String
    let name: String
    let country: String
    let profilePicture: String?
    let isPremium: Bool
    let xp: Int?
    let rank: String?
}

struct UserStatsResponse: Codable {
    let status: String
    let message: String
    let data: UserStats
}

struct UserStats: Codable {
    let xp: Int
    let score: Int
    let rank: String
    let globalRankPosition: Int
    let localRankPosition: Int
    let correctCount: Int
    let wrongCount: Int
    let averageDuration: Double
    let totalDuration: Double
    let isPremium: Bool
}


struct QuestionResponse: Codable {
    let data: Question
}

struct Question: Codable {
    let id: String
    let questionText: String?
    let imageUrl: String?
    let options: [Option]
    let type: String
}

enum QuestionType: String, Codable {
    case multipleChoice = "multiple"
    case open = "open"
}

struct Option: Codable {
    let text: String
}

struct Answer: Codable {
    let id: String
    let text: String
    let image: String?
    let isCorrect: Bool
}

struct SubmitAnswerResponse: Codable {
    let status: String
    let message: String
    let data: SubmitAnswerData
}

struct SubmitAnswerData: Codable {
    let isCorrect: Bool
    let delta: Int
    let answer: String?
}

struct SubmitAnswerBody: Encodable {
    let questionId: String
    let selectedIndex: Int
    let duration: Int
}

struct SubmitTextAnswerBody: Encodable {
    let questionId: String
    let answer: String
    let duration: Int
}


