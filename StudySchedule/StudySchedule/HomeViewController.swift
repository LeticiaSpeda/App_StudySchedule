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

    private lazy var performanceCardView = CardResults(
        image: UIImage(
            systemName: "cellularbars"
        ) ?? UIImage(),
        titleText: "89%",
        descriptionText: "Desempenho"
    )

    private lazy var timeCardView = CardResults(
        image: UIImage(
            systemName: "deskclock"
        ) ?? UIImage(),
        titleText: "16h 48m",
        descriptionText: "Tempo"
    )

    private lazy var exerciseCardView = CardResults(
        image: UIImage(
            systemName: "list.bullet.rectangle.portrait"
        ) ?? UIImage(),
        titleText: "332",
        descriptionText: "Exercícios"
    )

    private lazy var periodSegmentedControl: UISegmentedControl = {
        let itens = ["Semana", "Mês", "Total"]
        let segmented = UISegmentedControl(items: itens)
        segmented.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.2)
        segmented.selectedSegmentTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmented.selectedSegmentIndex = 0
        segmented.setTitleTextAttributes([
            .foregroundColor: UIColor.primary
        ], for: .selected)
        segmented.enableViewCode()
        return segmented
    }()

    private lazy var storesSubjectsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 28
        view.enableViewCode()
        return view
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
        view.addSubview(periodSegmentedControl)
        view.addSubview(storesSubjectsView)

        horizontalStack.addArrangedSubview(performanceCardView)
        horizontalStack.addArrangedSubview(timeCardView)
        horizontalStack.addArrangedSubview(exerciseCardView)
    }

    func setupConstraints() {
        horizontalStack.makeConstraint {
            $0.top(reference: view.safeTop, padding: 22)
            $0.leading(reference: view.safeLeading, padding: 22)
            $0.trailing(reference: view.safeTrailing, padding: -22)
            $0.height(100)
        }

        periodSegmentedControl.makeConstraint {
            $0.top(reference: horizontalStack.bottom, padding: 20)
            $0.leading(reference: view.safeLeading, padding: 22)
            $0.trailing(reference: view.safeTrailing, padding: -22)
        }

        storesSubjectsView.makeConstraint {
            $0.top(reference: periodSegmentedControl.bottom, padding: 20)
            $0.leading(reference: view.safeLeading)
            $0.trailing(reference: view.safeTrailing)
            $0.bottom(reference: view.bottom)
        }
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
