import Foundation
import CoreGraphics

final class ImagesListService {
    static let shared = ImagesListService()
    private init() {}

    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")

    private var isLoading = false
    private var lastLoadedPage = 0

    private(set) var photos: [Photo] = []

    func fetchPhotosNextPage() {
        guard !isLoading else { return }
        isLoading = true

        let nextPage = lastLoadedPage + 1
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self else { return }

            let base = (nextPage - 1) * 10
            let new: [Photo] = (0..<10).map { i in
                let id = "fake_\(base + i)"
                let w: CGFloat = 1080
                let h: CGFloat = 720 + CGFloat((i % 3) * 120)
                let created = Calendar.current.date(byAdding: .day, value: -(base + i), to: Date())
                let thumb = URL(string: "https://picsum.photos/seed/\(id)/300/200")!
                let full  = URL(string: "https://picsum.photos/seed/\(id)/2000/1400")!
                return Photo(id: id,
                             size: CGSize(width: w, height: h),
                             createdAt: created,
                             thumbURL: thumb,
                             fullURL: full,
                             isLiked: (i % 2 == 0))
            }

            DispatchQueue.main.async {
                self.photos.append(contentsOf: new)
                self.lastLoadedPage = nextPage
                self.isLoading = false
                NotificationCenter.default.post(name: Self.didChangeNotification, object: self)
            }
        }
    }

    func changeLike(photoId: String, isLike: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let idx = photos.firstIndex(where: { $0.id == photoId }) {
            photos[idx].isLiked = isLike
        }
        NotificationCenter.default.post(name: Self.didChangeNotification, object: self)
        completion(.success(true))
    }
}
