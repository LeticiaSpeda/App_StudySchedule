import UIKit

class CardResults: UIView, ViewCode {

    private var image: UIImage
    private var titleText: String
    private var descriptionText: String

    private lazy var verticalStack: UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.distribution = .equalSpacing
        verticalStack.translate()
        return verticalStack
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translate()
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleText
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = descriptionText
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    init(image: UIImage, titleText: String, descriptionText: String) {
        self.image = image
        self.titleText = titleText
        self.descriptionText = descriptionText
        super.init(frame: .zero)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    func configureHierachy() {
        verticalStack.addArrangedSubview(iconImageView)
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(descriptionLabel)

        addSubview(verticalStack)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 14
            ),
            verticalStack.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 8
            ),
            verticalStack.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -8
            ),
            verticalStack.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -14
            )
        ])
    }

    func configureStyle() {
        backgroundColor = .white
        layer.cornerRadius = 22
    }
}
