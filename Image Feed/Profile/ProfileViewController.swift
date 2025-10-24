import UIKit

final class ProfileViewController: UIViewController {
    private var label: UILabel?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let profileImage = UIImage(systemName: "person.crop.circle.fill")
            let imageView = UIImageView(image: profileImage)
            imageView.tintColor = .gray
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            
            let label = UILabel()
            label.text = "Екатерина Новикова"
            label.textColor = .white
            label.font = .systemFont(ofSize: 24)
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
            self.label = label
            
            let button = UIButton.systemButton(
                with: UIImage(systemName: "ipad.and.arrow.forward")!,
                target: self,
                action: #selector(Self.didTapButton)
            )
            button.tintColor = .red
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
            button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
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
