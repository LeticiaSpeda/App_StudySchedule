import UIKit

protocol ViewCode {
    func commonInit()
    func configureHierachy()
    func configureConstraints()
    func configureStyle()
}
extension UIView {
    func translate() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension ViewCode {
    func commonInit() {
        configureStyle()
        configureHierachy()
        configureConstraints()
    }

    func configureStyle() {

    }
}
