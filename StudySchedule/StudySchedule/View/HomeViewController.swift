import UIKit

class HomeViewController: UIViewController, ViewCode {
    private let viewModel = HomeViewModel()
    private let apiService = HomeService()
    private let homeCell = HomeViewCell()
    var studies: [Study] = []

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
        titleText: "",
        descriptionText: "Desempenho"
    )

    private lazy var timeCardView = CardResults(
        image: UIImage(
            systemName: "deskclock"
        ) ?? UIImage(),
        titleText: "",
        descriptionText: "Tempo"
    )

    private lazy var exerciseCardView = CardResults(
        image: UIImage(
            systemName: "list.bullet.rectangle.portrait"
        ) ?? UIImage(),
        titleText: "",
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

    private lazy var storesSubjectsTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.enableViewCode()
        table.register(
            HomeViewCell.self,
            forCellReuseIdentifier: HomeViewCell.identifier
        )
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        loadData()
        storesSubjectsTableView.reloadData()
    }

    @objc
    func handleList() {
        print("click")
    }

    private func loadData() {
        handlerPerformanceResult()
        handleTimeResult()
        handlerExerciseResult()
        handleStudyResult()
    }

    private func handlerPerformanceResult() {
        apiService.loadPerformance { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let performance):
                    self?.performanceCardView.setText("\(performance.performance)%")
                case .failure(let error):
                    self?.performanceCardView.setText("Indisponível")
                    self?.presentErrorAlert(
                        "Erro no sistema",
                        message: "Tente novamente mais tarde! (\(error.localizedDescription))"
                    )
                }
            }
        }
    }

    private func handleTimeResult() {
        apiService.loadTime { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let timer):
                    let time = self?.setupTime(with: timer.duration) ?? String()
                    self?.timeCardView.setText(time)
                case .failure(let error):
                    self?.presentErrorAlert(
                        "Erro no sistema",
                        message: "Não foi possível carregar informações sobre o tempo (\(error.localizedDescription))"
                    )
                }
            }
        }
    }

    private func handlerExerciseResult() {
        apiService.loadExercises { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let exercise):
                    self?.exerciseCardView.setText("\(exercise.exerciseStudied)")
                case .failure(let error):
                    self?.exerciseCardView.setText("Indisponível")
                    self?.presentErrorAlert(
                        "Erro no sistema",
                        message: "Não foi possível carregar informações sobre os exercícios (\(error.localizedDescription))"
                    )
                }
            }
        }
    }

    private func handleStudyResult() {
        apiService.loadStudies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.studies =  data.studies
                    self?.storesSubjectsTableView.reloadData()
                case .failure(let error):
                    self?.presentErrorAlert(
                        "Erro no sistema",
                        message: "Não foi possível carregar informações sobre as materias (\(error.localizedDescription))"
                    )
                }
            }
        }
    }

    private func setupTime(with duration: Int) -> String {
        let hours = duration / 3600000
        let minutes = (duration % 3600000) / 60000
        return "\(hours)h \(minutes)m"
    }

    private func presentErrorAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }

    func setupHierarchy() {
        view.add(horizontalStack)
        view.add(periodSegmentedControl)
        view.add(storesSubjectsView)

        horizontalStack.addArrangedSubview(performanceCardView)
        horizontalStack.addArrangedSubview(timeCardView)
        horizontalStack.addArrangedSubview(exerciseCardView)

        storesSubjectsView.addSubview(storesSubjectsTableView)
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

        storesSubjectsTableView.makeConstraint {
            $0.top(reference: storesSubjectsView.top, padding: 16)
            $0.leading(reference: storesSubjectsView.leading, padding: 16)
            $0.trailing(reference: storesSubjectsView.trailing, padding: -16)
            $0.bottom(reference: storesSubjectsView.bottom, padding: -16)
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewCell.identifier, for: indexPath) as? HomeViewCell {
            let study = studies[indexPath.row]

            cell.titleLabel.text = study.subject
            cell.timeLabel.text = "\(setupTime(with: study.timeSpend))"
            cell.numberExerciceLabel.text = "\(study.totalExercises)"

            return cell
        }
        return UITableViewCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
