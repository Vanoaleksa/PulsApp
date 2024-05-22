
import UIKit
import SnapKit

final class TestCollectionViewCell: UICollectionViewCell {
    
    lazy var mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "testVC-image")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.text = "Quick Depression Test"
        
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
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .black
        label.text = "This depression test or depression screening quiz will quickly help you determine whether you..."
        label.numberOfLines = 0
        
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
        self.layer.cornerRadius = 16
        self.backgroundColor = .white
    }
    
    private func setupLayout() {
        mainImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        proLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(3)
            make.trailing.equalToSuperview()
            make.width.equalToSuperview().dividedBy(7)
            make.height.equalTo(12)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(8)
            
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(8)
            make.trailing.equalTo(-8)
//            make.bottom.equalToSuperview()
        }
    }
}
