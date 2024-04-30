
import UIKit
import SnapKit

final class BackgroundHistoryView: UIView {
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundHistoryVC")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Statistical data"
        let customFont = UIFont(name: "SFProDisplay-Bold", size: 28.adjusted)
        label.font = customFont
        label.textColor = .white
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var leftArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "leftArrow")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var rightArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightArrow")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.text = "February 15"
        label.font = .systemFont(ofSize: 14.adjusted, weight: .regular)
        label.textColor = .white
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var pulseStatisticalImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pulseStatisticalImage")
        //        imageView.clipsToBounds = true
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var dayTimeLapseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dayTimeLapseImage")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var weekTimeLapseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "weekTimeLapseImage")
        imageView.isHidden = true
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var monthTimeLapseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "monthTimeLapseImage")
        imageView.isHidden = true
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.layer.cornerRadius = 20.adjusted
    }
    
    private func setupLayout() {
        
//        self.snp.makeConstraints { make in
//            make.height.equalTo(493)
//        }
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(60)
        }
        
        leftArrowImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(75)
            make.leading.equalTo(35)
            make.width.equalToSuperview().dividedBy(47)
            make.height.equalToSuperview().dividedBy(27)
            
        }
        
        rightArrowImage.snp.makeConstraints { make in
            make.top.equalTo(leftArrowImage)
            make.trailing.equalTo(-35)
            make.width.equalTo(leftArrowImage)
            make.height.equalTo(leftArrowImage)
            
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(rightArrowImage)
            make.height.equalToSuperview().dividedBy(27)
            
        }
        
        pulseStatisticalImage.snp.makeConstraints { make in
            make.top.equalTo(rightArrowImage.snp.bottom).offset(20)
            make.leading.equalTo(15)
            make.trailing.equalTo(-15)
            make.height.equalToSuperview().dividedBy(2.8)
        }
        
        dayTimeLapseImage.snp.makeConstraints { make in
            make.top.equalTo(pulseStatisticalImage.snp.bottom).offset(10)
            make.trailing.equalTo(pulseStatisticalImage.snp.trailing)
            make.leading.equalTo(pulseStatisticalImage.snp.leading).offset(35)
            make.height.equalToSuperview().dividedBy(20)
        }
        
        weekTimeLapseImage.snp.makeConstraints { make in
            make.top.equalTo(dayTimeLapseImage)
            make.trailing.equalTo(pulseStatisticalImage.snp.trailing)
            make.leading.equalTo(pulseStatisticalImage.snp.leading).offset(35)
            make.height.equalToSuperview().dividedBy(20)
        }
        
        monthTimeLapseImage.snp.makeConstraints { make in
            make.top.equalTo(dayTimeLapseImage)
            make.trailing.equalTo(pulseStatisticalImage.snp.trailing)
            make.leading.equalTo(pulseStatisticalImage.snp.leading).offset(40)
            make.height.equalToSuperview().dividedBy(45)
        }
        
    }
}

