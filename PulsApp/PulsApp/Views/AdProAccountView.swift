
import UIKit
import SnapKit

final class AdProAccountView: UIView {
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Upgrade to a PRO account"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor(red: 63/255, green: 49/255, blue: 232/255, alpha: 1)
        button.layer.cornerRadius = 16
        
        self.addSubview(button)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 1)
        self.layer.cornerRadius = 17
    }
    
    private func setupLayout() {
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(15)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-15)
            make.height.equalTo(31)
            make.width.equalToSuperview().dividedBy(4.3)
        }
    }
    
}
