import UIKit

class HomeViewController: UIViewController, ViewCode {
    private var viewModel = HomeViewModel()

    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.enableViewCode()
        return stack
    }()

    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.enableViewCode()
        return stack
    }()

    private lazy var performanceCardView = CardResults(
        image: UIImage(systemName: "cellularbars") ?? UIImage(),
        titleText: "89%",
        descriptionText: "Desempenho"
    )

    private lazy var timeCardView = CardResults(
        image: UIImage(systemName: "deskclock") ?? UIImage(),
        titleText: "16h 48m", descriptionText: "Tempo"
    )

    private lazy var exerciseCardView = CardResults(
        image: UIImage(systemName: "list.bullet.rectangle.portrait") ?? UIImage(),
        titleText: "332",
        descriptionText: "Exercícios"
    )

    private lazy var periodSegmentedControl: UISegmentedControl = {
        let itens = ["Semana", "Mês", "Total"]
        let segmented = UISegmentedControl(items: itens)
        segmented.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.2)
        segmented.selectedSegmentTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmented.selectedSegmentIndex = 0
        segmented.setTitleTextAttributes([.foregroundColor: UIColor.primary], for: .selected)
        segmented.layer.cornerRadius = 12
        segmented.enableViewCode()
        return segmented
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

    @objc
    func handleList() {
        print("click")
    }

    func setupHierarchy() {
        view.addSubview(horizontalStack)
        view.addSubview(verticalStack)

        horizontalStack.addArrangedSubview(performanceCardView)
        horizontalStack.addArrangedSubview(timeCardView)
        horizontalStack.addArrangedSubview(exerciseCardView)

        verticalStack.addArrangedSubview(periodSegmentedControl)
        verticalStack.addArrangedSubview(UIView())
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 22
            ),
            horizontalStack.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 22
            ),
            horizontalStack.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -22
            ),
            horizontalStack.heightAnchor.constraint(equalToConstant: 100),

            verticalStack.topAnchor.constraint(
                equalTo: horizontalStack.bottomAnchor,
                constant: 22
            ),
            verticalStack.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 22
            ),
            verticalStack.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -22
            ),
            verticalStack.heightAnchor.constraint(equalToConstant: 600)

        ])
    }

    func setupStyle() {
        view.backgroundColor = .primary
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationItem.title = viewModel.getTitle()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationItem.leftBarButtonItem = .init(
            image: UIImage(systemName: "text.justify"),
            style: .done,
            target: self,
            action: #selector(handleList)
        )
    }
}
