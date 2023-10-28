import UIKit

protocol ViewCode {
    func commonInit()
    func setupHierarchy()
    func setupConstraints()
    func setupStyle()
}

extension ViewCode {
    func commonInit() {
        setupStyle()
        setupHierarchy()
        setupConstraints()
    }

    func setupStyle() {

    }
}

extension UIView {
    func enableViewCode() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

public extension UIView {

    func add(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }

    var top: NSLayoutYAxisAnchor {
        topAnchor
    }

    var safeTop: NSLayoutYAxisAnchor {
        safeAreaLayoutGuide.topAnchor
    }

    var leading: NSLayoutXAxisAnchor {
        leadingAnchor
    }

    var safeLeading: NSLayoutXAxisAnchor {
        safeAreaLayoutGuide.leadingAnchor
    }

    var trailing: NSLayoutXAxisAnchor {
        trailingAnchor
    }

    var safeTrailing: NSLayoutXAxisAnchor {
        safeAreaLayoutGuide.trailingAnchor
    }

    var bottom: NSLayoutYAxisAnchor {
        bottomAnchor
    }

    var safeBottom: NSLayoutYAxisAnchor {
        safeAreaLayoutGuide.bottomAnchor
    }

    var centerX: NSLayoutXAxisAnchor {
        centerXAnchor
    }

    var safeCenterX: NSLayoutXAxisAnchor {
        safeAreaLayoutGuide.centerXAnchor
    }

    var centerY: NSLayoutYAxisAnchor {
        centerYAnchor
    }

    var safeCenterY: NSLayoutYAxisAnchor {
        safeAreaLayoutGuide.centerYAnchor
    }

    var width: NSLayoutDimension {
        widthAnchor
    }

    var safeWidth: NSLayoutDimension {
        safeAreaLayoutGuide.widthAnchor
    }

    var height: NSLayoutDimension {
        heightAnchor
    }

    var safeHeight: NSLayoutDimension {
        safeAreaLayoutGuide.widthAnchor
    }

    func makeConstraint(_ constraintable: (Constraintable) -> Void) {
        constraintable(Constraintable(support: self))
    }

    struct Constraintable {
        private let support: UIView

        public init(support: UIView) {
            self.support = support
            self.support.enableViewCode()
        }

        public func top(reference: NSLayoutYAxisAnchor, padding: CGFloat = .zero) {
            apply(in: support.top, at: reference, with: padding)
        }

        public func bottom(reference: NSLayoutYAxisAnchor, padding: CGFloat = .zero) {
            apply(in: support.bottom, at: reference, with: padding)
        }

        public func leading(reference: NSLayoutXAxisAnchor, padding: CGFloat = .zero) {
            apply(in: support.leading, at: reference, with: padding)
        }

        public func trailing(reference: NSLayoutXAxisAnchor, padding: CGFloat = .zero) {
            apply(in: support.trailing, at: reference, with: padding)
        }

        public func centerX(reference: NSLayoutXAxisAnchor, padding: CGFloat = .zero) {
            apply(in: support.centerX, at: reference, with: padding)
        }

        public func centerY(reference: NSLayoutYAxisAnchor, padding: CGFloat = .zero) {
            apply(in: support.centerY, at: reference, with: padding)
        }

        public func height(_ value: CGFloat) {
            apply(in: support.height, with: value)
        }

        public func width(_ value: CGFloat) {
            apply(in: support.width, with: value)
        }

        public func size(_ size: CGSize) {
            height(size.height)
            width(size.width)
        }

        public func size(_ size: CGFloat) {
            height(size)
            width(size)
        }

        public func equal(to view: UIView?) {
            guard let view = view else {  return }

            top(reference: view.top)
            leading(reference: view.leading)
            trailing(reference: view.trailing)
            bottom(reference: view.bottom)
        }

        public func safeEqual(to view: UIView) {
            top(reference: view.safeTop)
            leading(reference: view.safeLeading)
            trailing(reference: view.safeTrailing)
            bottom(reference: view.safeBottom)
        }

        // MARK: - Helpers
        private func active(_ constraint: NSLayoutConstraint) {
            constraint.isActive = true
        }

        private func apply(
            in item: NSLayoutYAxisAnchor,
            at reference: NSLayoutYAxisAnchor,
            with padding: CGFloat
        ) {
            active(item.constraint(equalTo: reference, constant: padding))
        }

        private func apply(
            in item: NSLayoutXAxisAnchor,
            at reference: NSLayoutXAxisAnchor,
            with padding: CGFloat
        ) {
            active(item.constraint(equalTo: reference, constant: padding))
        }

        private func apply(in item: NSLayoutDimension, with size: CGFloat) {
            active(item.constraint(equalToConstant: size))
        }
    }
}
