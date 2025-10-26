import UIKit

final class ProfileViewController: UIViewController {
    private var label: UILabel?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let imageView = UIImageView(image: UIImage(named: "avatar"))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 35
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 52).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            
            let label = UILabel()
            label.text = "Екатерина Новикова"
            label.textColor = .white
            label.font = .systemFont(ofSize: 23, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24).isActive = true
            self.label = label
            
            let usernameLabel = UILabel()
            usernameLabel.text = "@ekaterina_nov"
            usernameLabel.textColor = UIColor(named: "YPGray")
            usernameLabel.font = .systemFont(ofSize: 13, weight: .regular)
            usernameLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(usernameLabel)

            NSLayoutConstraint.activate([
                usernameLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor),
                usernameLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
                usernameLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])

            let descriptionLabel = UILabel()
            descriptionLabel.text = "Hello, world!"
            descriptionLabel.textColor = .white
            descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
            descriptionLabel.numberOfLines = 0
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(descriptionLabel)

            NSLayoutConstraint.activate([
                descriptionLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
                descriptionLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
                descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ])

            
            let button = UIButton.systemButton(
                with: UIImage(systemName: "ipad.and.arrow.forward")!,
                target: self,
                action: #selector(Self.didTapButton)
            )
            button.tintColor = UIColor(named: "YPRed")
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)

            NSLayoutConstraint.activate([
                button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
                button.widthAnchor.constraint(greaterThanOrEqualToConstant: 44),
                button.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
            ])

        }
        
        @objc
        private func didTapButton() {
            
            label?.removeFromSuperview()
            label = nil
            
            for view in view.subviews {
                if view is UILabel {
                    view.removeFromSuperview()
                }
            }
        }
}
