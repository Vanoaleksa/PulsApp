
import UIKit
import SnapKit

protocol DatePickerViewDelegate: NSObject {
    func tappedActionInPrivacyView()
}

final class DatePickerView: UIView {
    
    weak var delegate: DatePickerViewDelegate?
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        self.addSubview(datePicker)
        
        return datePicker
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select month"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        
        self.addSubview(label)
        
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.addSubview(button)
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @objc func buttonAction() {
        delegate?.tappedActionInPrivacyView()
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-15)
            make.width.equalToSuperview().dividedBy(10)
            make.height.equalTo(19)
        }
        
        datePicker.snp.makeConstraints { make in
            make.center.equalToSuperview()
//            make.top.equalToSuperview().offset(50)
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
}
