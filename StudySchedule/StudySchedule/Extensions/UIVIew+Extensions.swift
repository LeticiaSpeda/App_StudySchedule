import UIKit

protocol ViewCode {
    func commonInit()
    func setupHierarchy()
    func setupConstraints()
    func setupStyle()
}

extension UIView {
    func enableViewCode() {
        translatesAutoresizingMaskIntoConstraints = false
    }
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
