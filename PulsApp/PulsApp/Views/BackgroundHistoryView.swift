
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
    
    lazy var pulseStatisticalImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pulseStatisticalImage")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    private var stackView = UIStackView()
    private var dayPeriod = PeriodView(periods: .day)
    private var weekPeriod = PeriodView(periods: .week)
    private var monthPeriod = PeriodView(periods: .month)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
//        self.image.image = UIImage(named: "backgroundHistoryVC")
        self.layer.cornerRadius = 20.adjusted
        
        //config stackView
        self.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
    
        stackView.addArrangedSubview(dayPeriod)
        stackView.addArrangedSubview(weekPeriod)
        stackView.addArrangedSubview(monthPeriod)

    }
    
    private func setupLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18.adjusted)
//            make.top.equalTo(view.snp.topMargin).offset(20.adjusted)
            make.top.equalToSuperview().offset(20.adjusted)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15.adjusted)
            make.centerX.equalToSuperview()
        }
        
        pulseStatisticalImage.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(40.adjusted)
            make.leading.equalTo(20.adjusted)
            make.trailing.equalTo(-20.adjusted)
//            make.height.equalTo(UIScreen.main.bounds.width == 375 ? 115 : 140)
//            make.height.equalTo(140.adjusted)
            make.height.equalToSuperview().dividedBy(3)
//            make.height.equalToSuperview().multipliedBy(0.2)
        }
    }
}
