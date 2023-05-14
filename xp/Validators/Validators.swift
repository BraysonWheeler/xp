//
//  validators.swift
//  xp
//
//  Created by Logan Wheeler on 4/15/23.
//

import Foundation
import SwiftUI

struct Message : Identifiable{
   let id = UUID()
   let text: String
}

func DoesUsernameExist(username:String) -> Bool {
    var query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: username,
        kSecAttrService as String: "xp-app",
        kSecMatchLimit as String: kSecMatchLimitOne
    ]
    let status = SecItemCopyMatching(query as CFDictionary, nil)
    guard status == errSecSuccess else {
        return false
    }
    return true
}

func validateUsername(username:String) -> [Message] {
    var messages:[Message] = []
    if username.count < 3 {
        messages.append(Message(text: "Username must be atleast 3 character"))
        return messages
    }
    else if DoesUsernameExist(username:username) {
        messages.append(Message(text: "Username already exists"))
    }
    return messages
}


func checkSpecialCharacterValid(password:String) -> Bool{
    return (password.range(of: specialCharacterPattern, options: .regularExpression) != nil) ? true : false
}

func checkPasswordLengthValid(password:String) -> Bool{
    return password.count > minimumPasswordLength ? true : false
}
