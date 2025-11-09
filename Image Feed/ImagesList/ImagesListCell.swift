import UIKit

protocol ImagesListCellDelegate: AnyObject {
    func imagesListCellDidTapLike(_ cell: ImagesListCell)
}

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    weak var delegate: ImagesListCellDelegate?

    @IBAction private func likeTapped() {
        delegate?.imagesListCellDidTapLike(self)
    }

    func setIsLiked(_ isLiked: Bool) {
        let name = isLiked ? "like_button_on" : "like_button_off"
        likeButton.setImage(UIImage(named: name), for: .normal)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.image = nil
    }
}
