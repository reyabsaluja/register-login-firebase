//
//  User.swift
//  FBAuth
//
//  Created by Reyab Saluja on 2023-10-02.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable, Hashable {
    @DocumentID var uid: String?
    let fullname: String
    let email: String
    var profilePicURL: String?
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
}

extension User {
    static var MOCK_USER = User(fullname: "Kobe Bryant", email: "kobebryant@gmail.com")
}
