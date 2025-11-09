import Foundation

enum Constants {
    static let accessKey = "SywUS-3yBth3U7m5Nc29WCUceT-W90bcd7mZG-BXKxA"
    static let secretKey = "hbiFboZj8A4RhqP4vgom8Sl5zN2PeBap1XOclCJ67Ec"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL: URL = {
        guard let url = URL(string: "https://api.unsplash.com") else {
            fatalError("Invalid base URL")
        }
        return url
    }()
}

