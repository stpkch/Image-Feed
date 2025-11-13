//
//  OAuthTokenResponse.swift
//  Image Feed
//
//  Created by Качусов Степан on 11.11.2025.
//

import Foundation

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
}
