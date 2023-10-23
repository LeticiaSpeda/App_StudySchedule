import UIKit

final class UIStackViewCustons: UIStackView {

    private var position: NSLayoutConstraint.Axis
    private var space: CGFloat

    init(position: NSLayoutConstraint.Axis, space: CGFloat) {
        self.position = position
        self.space = space
        super.init(frame: .zero)
        configureStack()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureStack() {
        axis = position
        spacing = space
        translate()
    }
}
