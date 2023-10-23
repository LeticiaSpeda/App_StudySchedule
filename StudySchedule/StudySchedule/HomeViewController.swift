import UIKit

class HomeViewController: UIViewController, ViewCode {

    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translate()
        return stack
    }()

    private lazy var performanceCardView = CardResults(image: UIImage(systemName: "cellularbars")!, titleText: "89%", descriptionText: "Desempenho")

    private lazy var timeCardView = CardResults(image: UIImage(systemName: "deskclock")!, titleText: "16h 48m", descriptionText: "Tempo")

    private lazy var exerciseCardView = CardResults(image: UIImage(systemName: "list.bullet.rectangle.portrait")!, titleText: "332", descriptionText: "Exercícios")

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

    @objc func handleList() {

    }

    func configureHierachy() {
        view.addSubview(horizontalStack)

        horizontalStack.addArrangedSubview(performanceCardView)
        horizontalStack.addArrangedSubview(timeCardView)
        horizontalStack.addArrangedSubview(exerciseCardView)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            horizontalStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 22),
            horizontalStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -22),
            horizontalStack.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    func configureStyle() {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd 'de' MMMM"
        formatter.locale = Locale(identifier: "pt-BR")

        view.backgroundColor = #colorLiteral(red: 0.2784313725, green: 0.3450980392, blue: 0.7215686275, alpha: 1)
        navigationItem.title = formatter.string(from: now)

        navigationController?.navigationBar.tintColor = .white

        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.leftBarButtonItem = .init(
            image: UIImage(systemName: "text.justify"),
            style: .done,
            target: self,
            action: #selector(handleList)
        )
    }
}
