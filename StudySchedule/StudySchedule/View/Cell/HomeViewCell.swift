import UIKit

final class HomeViewCell: UITableViewCell, ViewCode {
    static let identifier = String(describing: HomeViewCell.self)

    private lazy var contentTrophyView: UIView = {
        let view = UIView()
        view.enableViewCode()
        view.layer.cornerRadius = 12
        view.backgroundColor = #colorLiteral(red: 0.006200197153, green: 0.4592633843, blue: 0.7387693524, alpha: 1)
        return view
    }()

    private lazy var contentTrophyImage: UIImageView = {
        let imageView = UIImageView(image: UIImage.trophy)
        imageView.contentMode = .scaleAspectFill
        imageView.enableViewCode()
        return imageView
    }()

    private lazy var contentTimeImage: UIImageView = {
        let imageView = UIImageView(image: UIImage.clock)
        imageView.contentMode = .scaleAspectFill
        imageView.enableViewCode()
        return imageView
    }()

    private lazy var contentExerciseImage: UIImageView = {
        let imageView = UIImageView(image: UIImage.exercise)
        imageView.contentMode = .scaleAspectFill
        imageView.enableViewCode()
        return imageView
    }()

    private lazy var contentEvolutionImage: UIImageView = {
        let imageView = UIImageView(image: UIImage.evolution)
        imageView.contentMode = .scaleAspectFill
        imageView.enableViewCode()
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Matemática"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.enableViewCode()
        return label
    }()

    private lazy var rankingLabel: UILabel = {
        let label = UILabel()
        label.text = "1°"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.enableViewCode()
        return label
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "05h 08m"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        label.enableViewCode()
        return label
    }()

    private lazy var numberExerciceLabel: UILabel = {
        let label = UILabel()
        label.text = "128"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        label.enableViewCode()
        return label
    }()

    private lazy var numberEvolutionLabel: UILabel = {
        let label = UILabel()
        label.text = "90%"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        label.enableViewCode()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    func setupHierarchy() {
        contentView.addSubview(contentTrophyView)
        contentTrophyView.add(contentTrophyImage)
        contentTrophyView.add(rankingLabel)
        contentTrophyView.add(titleLabel)
        contentTrophyView.add(contentTimeImage)
        contentTrophyView.add(timeLabel)
        contentTrophyView.add(contentExerciseImage)
        contentTrophyView.add(numberExerciceLabel)
        contentTrophyView.add(contentEvolutionImage)
        contentTrophyView.add(numberEvolutionLabel)
    }

    func setupConstraints() {

        contentTrophyView.makeConstraint {
            $0.top(reference: contentView.top, padding: 12)
            $0.leading(reference: contentView.leading, padding: 10)
            $0.trailing(reference: contentView.trailing, padding: -10)
            $0.bottom(reference: contentView.bottom, padding: -12)
            $0.height(80)
        }

        rankingLabel.makeConstraint {
            $0.top(reference: contentTrophyView.top, padding: 10)
            $0.leading(reference: contentTrophyView.leading, padding: 10)
        }

        contentTrophyImage.makeConstraint {
            $0.top(reference: contentTrophyView.top, padding: 10)
            $0.leading(reference: rankingLabel.trailing, padding: 10)
            $0.bottom(reference: contentTrophyView.bottom, padding: -10)
            $0.height(50)
            $0.width(50)
        }

        titleLabel.makeConstraint {
            $0.top(reference: contentTrophyView.top, padding: 10)
            $0.leading(reference: contentTrophyImage.trailing, padding: 10)
        }

        contentTimeImage.makeConstraint {
            $0.leading(reference: contentTrophyImage.trailing, padding: 10)
            $0.bottom(reference: contentTrophyView.bottom, padding: -10)
            $0.height(20)
            $0.width(20)
        }

        timeLabel.makeConstraint {
            $0.bottom(reference: contentTrophyView.bottom, padding: -10)
            $0.leading(reference: contentTimeImage.trailing, padding: 4)
        }

        contentExerciseImage.makeConstraint {
            $0.bottom(reference: contentTrophyView.bottom, padding: -10)
            $0.leading(reference: timeLabel.trailing, padding: 10)
            $0.height(18)
            $0.width(18)
        }

        numberExerciceLabel.makeConstraint {
            $0.bottom(reference: contentTrophyView.bottom, padding: -10)
            $0.leading(reference: contentExerciseImage.trailing, padding: 4)
        }

        contentEvolutionImage.makeConstraint {
            $0.bottom(reference: contentTrophyView.bottom, padding: -10)
            $0.leading(reference: numberExerciceLabel.trailing, padding: 10)
            $0.height(18)
            $0.width(18)
        }

        numberEvolutionLabel.makeConstraint {
            $0.bottom(reference: contentTrophyView.bottom, padding: -10)
            $0.leading(reference: contentEvolutionImage.trailing, padding: 4)
        }

    }

    func setupStyle() {
        backgroundColor = .white.withAlphaComponent(0.0)
    }

}
