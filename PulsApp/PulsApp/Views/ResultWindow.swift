

import UIKit

protocol ResultWindowActionsDelegate:AnyObject {
    func tappedButtonOK()
}

class ResultWindow: UIView {
    
    weak var delegateResult: ResultWindowActionsDelegate?
    var typeResult: ResultType!
    var pulseType: PulseTypeView!
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Result"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.text = "February 15 2021, 11:47 AM"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 0.3)
        label.textAlignment = .left
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var titleHearth: UILabel = {
        var label = UILabel()
        label.text = "Heart rate Tips"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var pulseLabel: UILabel = {
        var label = UILabel()
        label.text = "00"
        label.font = .systemFont(ofSize: 50, weight: .medium)
        label.textColor = .black
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var bpmLabel: UILabel = {
        var label = UILabel()
        label.text = "bpm"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var heartImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "red-heart")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var descriptionHearth: UILabel = {
        var label = UILabel()
        label.text = "Many lifestyle habits can maintain a healthy heart rate, and a healthy diet helps to keep your heart rate slow for a long time. Eat more vegetables and fruits, and eat less foods high in fat and cholesterol."
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var okButton: GlobalButton = {
        var button = GlobalButton()
        button.setTitle("OK", for: .normal)
                button.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
        
        self.addSubview(button)
        
        return button
    }()
    
    var updateCompletion: ((_ bpm: Int, _ date: Double, _ analyzeType: AnalyzeTypes, _ pulseType: PulseType) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
        
        updateCompletion = { bpm, date, analyzeType, typePulse in
            self.pulseLabel.text = String(bpm)
            self.dateLabel.text = self.formatDate(dateInterval: date)
            self.typeResult.updateAnalyze?(analyzeType)
            self.pulseType.updateType?(typePulse)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 30
        
        typeResult = ResultType()
        pulseType = PulseTypeView()
        
        self.addSubview(typeResult)
        self.addSubview(pulseType)
        
    }
    
    private func formatDate(dateInterval:Double) -> String{
        let date = Date(timeIntervalSince1970: dateInterval)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = " MMMM dd yyyy h:mm a "
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    @objc func okButtonAction() {
        delegateResult?.tappedButtonOK()
    }
    
    private func setupLayout() {
        okButton.snp.makeConstraints { make in
            make.bottom.equalTo(-60.adjusted)
            make.centerX.equalToSuperview()
            make.leading.equalTo(40.adjusted)
            make.right.equalTo(-40.adjusted)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(16.adjusted)
            make.centerX.equalToSuperview()
            make.height.equalTo(24.adjusted)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28.adjusted)
            make.leading.equalTo(18.adjusted)
            make.height.equalTo(14.adjusted)
        }
        
        heartImageView.snp.makeConstraints { make in
            make.leading.equalTo(18.adjusted)
            make.top.equalTo(dateLabel.snp.bottom).offset(25.adjusted)
            make.height.equalTo(18.adjusted)
            make.width.equalTo(20.adjusted)
        }
        
        pulseLabel.snp.makeConstraints { make in
            make.leading.equalTo(heartImageView.snp.trailing).offset(10.adjusted)
            make.centerY.equalTo(heartImageView)
        }
        
        bpmLabel.snp.makeConstraints { make in
            make.leading.equalTo(pulseLabel.snp.trailing).offset(5.adjusted)
            make.bottom.equalTo(heartImageView.snp.bottom).offset(10.adjusted)
        }
        
        titleHearth.snp.makeConstraints { make in
            make.top.equalTo(pulseLabel.snp.bottom).offset(60.adjusted)
            make.leading.equalTo(18.adjusted)
        }
        
        descriptionHearth.snp.makeConstraints { make in
            make.top.equalTo(titleHearth.snp.bottom).offset(10.adjusted)
            make.left.equalTo(18.adjusted)
            make.right.equalTo(-18.adjusted)
        }
        
        typeResult.snp.makeConstraints { make in
            make.top.equalTo(68.adjusted)
            make.trailing.equalTo(-38.adjusted)
            make.width.equalTo(60.adjusted)
            make.height.equalTo(60.adjusted)
        }
        
        pulseType.snp.makeConstraints { make in
            make.top.equalTo(pulseLabel.snp.bottom).offset(15.adjusted)
            make.leading.equalTo(18.adjusted)
            make.width.equalTo(110.adjusted)
            make.height.equalTo(31.adjusted)
        }
    }
}
