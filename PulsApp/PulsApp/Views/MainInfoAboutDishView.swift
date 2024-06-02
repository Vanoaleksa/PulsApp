
import UIKit
import SnapKit

class MainInfoAboutDishView: UIView {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bacon and aggs"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Just four ingredients and a delicious breakfast is ready! So let's get started"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.alignment = .center
        
        return stackView
    }()
    
    lazy var kkalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 3
        
        return stackView
    }()
    
    lazy var timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 3
        
        return stackView
    }()
    
    lazy var servsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 3
        
        return stackView
    }()
    
    lazy var kkalImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "kkal-image")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var kkalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 10)
        label.text = "438 kcal"
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var alarmImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "alarm-image")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 10)
        label.text = "15 min"

        self.addSubview(label)
        
        return label
    }()
    
    lazy var servImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "fork-and-knife-image")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var servLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 10)
        label.text = "1 serving"

        self.addSubview(label)
        
        return label
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 60
        
        self.addSubview(mainStackView)
        self.addSubview(kkalStackView)
        self.addSubview(timeStackView)
        self.addSubview(servsStackView)
        
        kkalStackView.addArrangedSubview(kkalImage)
        kkalStackView.addArrangedSubview(kkalLabel)
        
        timeStackView.addArrangedSubview(alarmImage)
        timeStackView.addArrangedSubview(cookingTimeLabel)
        
        servsStackView.addArrangedSubview(servImage)
        servsStackView.addArrangedSubview(servLabel)
        
        mainStackView.addArrangedSubview(kkalStackView)
        mainStackView.addArrangedSubview(timeStackView)
        mainStackView.addArrangedSubview(servsStackView)

        
    }
    
    private func setupLayout() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-45)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(65)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(13)
        }
    }
    
}
