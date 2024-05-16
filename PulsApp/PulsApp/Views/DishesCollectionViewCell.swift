
import UIKit
import SnapKit

final class DishesCollectionViewCell: UICollectionViewCell {
    
    lazy var mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var dishNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var kkalImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "kkal-image")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var kkalLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 255/255, green: 134/255, blue: 56/255, alpha: 1)
        label.font = .systemFont(ofSize: 10)
        
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
        label.textColor = UIColor(red: 255/255, green: 134/255, blue: 56/255, alpha: 1)
        label.font = .systemFont(ofSize: 10)

        self.addSubview(label)
        
        return label
    }()
    
    lazy var proLabel: UILabel = {
        let label = UILabel()
        label.text = "PRO"
        label.backgroundColor = UIColor(red: 255/255, green: 206/255, blue: 56/255, alpha: 1)
        label.textColor = .white
        label.font = .systemFont(ofSize: 8)
        label.textAlignment = .center
        
        self.addSubview(label)
        
        return label
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.layer.cornerRadius = 16
        self.backgroundColor = .white
        
        self.addSubview(kkalStackView)
        self.addSubview(timeStackView)
        kkalStackView.addArrangedSubview(kkalImage)
        kkalStackView.addArrangedSubview(kkalLabel)
        timeStackView.addArrangedSubview(alarmImage)
        timeStackView.addArrangedSubview(cookingTimeLabel)
        
    }
    
    private func setupLayout() {
        mainImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(1.74)
        }
        
        proLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(3)
            make.trailing.equalToSuperview()
            make.width.equalToSuperview().dividedBy(7)
            make.height.equalTo(12)
        }
        
        dishNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(8)
        }
        
        kkalStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-13)
            make.leading.equalToSuperview().offset(12)
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(12)
        }
        
        timeStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-13)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(12)
        }
    }
}
