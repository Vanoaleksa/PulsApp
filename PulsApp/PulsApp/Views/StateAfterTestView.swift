
import UIKit
import SnapKit

final class StateAfterTestView: UIView {
    
    private var distanceForTriangle: Int = 0 {
        didSet {
            updateTrianglePosition()
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.text = "Mild anxiety "
        label.textAlignment = .left
        
        self.addSubview(label)
        
        return label
    }()
    
    let gradientStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.layer.cornerRadius = 16
        stackView.distribution = .fillEqually
        stackView.clipsToBounds = true
        
        return stackView
    }()
    
    lazy var leftMeasurmentLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var rightMeasurmentLabel: UILabel = {
        let label = UILabel()
        label.text = "80"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var triangleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Triangle")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createMulticolorLabels()
        setupLayout()        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createMulticolorLabels() {
        let colorsArr = [UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 0.2),
                         UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 0.3),
                         UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 0.4),
                         UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 0.5),
        ]
        
        for color in colorsArr {
            let label = UILabel()
            label.backgroundColor = color
            
            gradientStackView.addArrangedSubview(label)
        }
        
        self.addSubview(gradientStackView)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(20)
        }
        
        gradientStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(31)
        }
        
        leftMeasurmentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(gradientStackView.snp.bottom).offset(5)
        }
        
        rightMeasurmentLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(gradientStackView.snp.bottom).offset(5)
        }
        
        triangleImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(distanceForTriangle)
            make.top.equalTo(gradientStackView.snp.bottom).offset(10)
        }
    }
    
    func setDistanceForTriangle(_ distance: Int) {
        self.distanceForTriangle = distance
    }
    
    private func updateTrianglePosition() {
        triangleImageView.snp.updateConstraints { make in
            make.leading.equalTo(distanceForTriangle)
        }
        
        layoutIfNeeded()
    }
}
