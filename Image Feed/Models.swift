import UIKit

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let thumbURL: URL
    let fullURL: URL
    var isLiked: Bool
}
