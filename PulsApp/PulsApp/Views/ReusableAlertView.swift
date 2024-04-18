
import UIKit
import SnapKit

enum ALertType {
    case camera
    case preview
}

protocol AlertViewDelegate: NSObject {
    func tappedActionInPrivacyView(forType type: ALertType)
}

class ReusableAlertView: UIView {
    
    weak var delegate: AlertViewDelegate?
    var globalButton = GlobalButton()
    var alertType: ALertType {
            didSet {
                updateLabels()
            }
        }

    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20.adjusted, weight: .medium)
        label.textColor = .black
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16.adjusted)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        
        self.addSubview(label)
        
        return label
    }()
    
    let darkView:UIView = {
        let view = UIView()
        view.alpha = 0.5
        view.backgroundColor = .black
        
        return view
    }()
    
    
    init(alertType: ALertType) {
        self.alertType = alertType
        super.init(frame: .zero)
        
        configUI()
        setupLayout()
        updateLabels()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(globalButton)
        self.globalButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.insertSubview(darkView, at: 0)

    }
    
    private func updateLabels() {
        switch alertType {
        case .camera:
            titleLabel.text = "Camera Access"
            descriptionLabel.text = "Pulse would like to access your camera to measure heart rate by collecting the light changes on your finger surface."
            globalButton.setTitle("OK", for: .normal)
            delegate?.tappedActionInPrivacyView(forType: .camera)
            
        case .preview:
            titleLabel.text = "Welcome to Pulse"
            descriptionLabel.text = "By clicking 'Accept and Continue', you confirm that you have read and accept our Privacy Policy Terms of Service"
            globalButton.setTitle("Accept and Continue", for: .normal)
            delegate?.tappedActionInPrivacyView(forType: .preview)
        }
    }
    
    @objc func buttonAction() {
        delegate?.tappedActionInPrivacyView(forType: alertType)
    }
    
    func setupLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.adjusted)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30.adjusted)
            make.right.equalToSuperview().offset(-10.adjusted)
            make.left.equalToSuperview().offset(10.adjusted)
            make.centerX.equalToSuperview()
        }
        
        globalButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(80.adjusted)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(40.adjusted)
            make.right.equalToSuperview().offset(-40.adjusted)
        }
    }
}


