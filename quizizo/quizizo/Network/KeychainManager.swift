//
//  KeychainManager.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 01.11.25.
//

import Foundation
import Security

final class KeychainManager {
    static let shared = KeychainManager()
    private init() {}

    func save(_ value: String, forKey key: String) {
        guard let data = value.data(using: .utf8) else { return }

        // Удаляем, если уже есть
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key]
        SecItemDelete(query as CFDictionary)

        // Добавляем новое значение
        let attributes: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                         kSecAttrAccount as String: key,
                                         kSecValueData as String: data]
        SecItemAdd(attributes as CFDictionary, nil)
    }

    func get(forKey key: String) -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key,
                                    kSecReturnData as String: true,
                                    kSecMatchLimit as String: kSecMatchLimitOne]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        guard status == errSecSuccess,
              let data = dataTypeRef as? Data,
              let value = String(data: data, encoding: .utf8) else { return nil }
        return value
    }

    func delete(forKey key: String) {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key]
        SecItemDelete(query as CFDictionary)
    }
}
