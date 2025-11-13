//
//  Profile.swift
//  Image Feed
//
//  Created by Качусов Степан on 11.11.2025.
//

import Foundation

struct Profile {
    let userName: String
    let name: String
    let loginName: String
    let bio: String?
    
    init(profileResult: ProfileResult){
        self.userName = profileResult.username
        self.loginName = "@\(profileResult.username)"
        
        var fullName = [String]()
        if let firsName = profileResult.firstName {
            fullName.append(firsName)
        }
        if let lastName = profileResult.lastName {
            fullName.append(lastName)
        }
        
        self.name = fullName.joined(separator: " ")
        
        self.bio = profileResult.bio
    }
}

struct ProfileResult: Decodable {
    let username: String
    let firstName: String?
    let lastName: String?
    let bio: String?
}


struct UserResult: Codable {
    let profileImage: ProfileImage
    
    struct ProfileImage: Codable {
        let small: String
    }
}

