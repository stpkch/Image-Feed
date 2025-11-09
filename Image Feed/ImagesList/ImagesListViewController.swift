import UIKit
import ProgressHUD
import Kingfisher

final class ImagesListViewController: UIViewController {
    private let showSingleImageSegueIdentifier = "ShowSingleImage"

    @IBOutlet private var tableView: UITableView!

    private let service = ImagesListService.shared
    private var photos: [Photo] { service.photos }

    private var changeObserver: NSObjectProtocol?

    private let dateFormatter = DateFormatters.dayMonthYear

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)


        changeObserver = NotificationCenter.default.addObserver(
            forName: ImagesListService.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.updateTableViewAnimated()
        }


        service.fetchPhotosNextPage()
    }

    deinit {
        if let changeObserver { NotificationCenter.default.removeObserver(changeObserver) }
    }

    // MARK: - Навигация к полноразмерному фото

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == showSingleImageSegueIdentifier,
              let vc = segue.destination as? SingleImageViewController,
              let indexPath = sender as? IndexPath
        else {
            super.prepare(for: segue, sender: sender)
            return
        }

        vc.photo = photos[indexPath.row]
    }

    // MARK: - Анимированное обновление таблицы

    private func updateTableViewAnimated() {
        let oldCount = tableView.numberOfRows(inSection: 0)
        let newCount = photos.count
        guard newCount > oldCount else { return }

        let indexPaths = (oldCount..<newCount).map { IndexPath(row: $0, section: 0) }
        tableView.performBatchUpdates({
            tableView.insertRows(at: indexPaths, with: .automatic)
        })
    }
}

// MARK: - UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ImagesListCell.reuseIdentifier,
            for: indexPath
        )

        guard let imageListCell = cell as? ImagesListCell else { return UITableViewCell() }

        imageListCell.delegate = self
        configure(cell: imageListCell, with: photos[indexPath.row])

        return imageListCell
    }
}

// MARK: - UITableViewDelegate

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showSingleImageSegueIdentifier, sender: indexPath)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == photos.count - 1 {
            service.fetchPhotosNextPage()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let photo = photos[indexPath.row]
        let insets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let width = tableView.bounds.width - insets.left - insets.right
        let scale = width / photo.size.width
        return photo.size.height * scale + insets.top + insets.bottom
    }
}

// MARK: - Конфиг ячейки

private extension ImagesListViewController {
    func configure(cell: ImagesListCell, with photo: Photo) {

        cell.cellImage.kf.setImage(with: photo.thumbURL)

        cell.dateLabel.text = photo.createdAt.map { dateFormatter.string(from: $0) } ?? ""

        cell.setIsLiked(photo.isLiked)
    }
}

// MARK: - Лайки (делегат ячейки) c блокировкой UI

extension ImagesListViewController: ImagesListCellDelegate {
    func imagesListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let photo = photos[indexPath.row]
        let newValue = !photo.isLiked

        UIBlockingProgressHUD.show()
        service.changeLike(photoId: photo.id, isLike: newValue) { [weak self] result in
            UIBlockingProgressHUD.dismiss()
            switch result {
            case .success:
                guard let self else { return }
                let updated = self.photos[indexPath.row].isLiked
                cell.setIsLiked(updated)
            case .failure:

                break
            }
        }
    }
}
