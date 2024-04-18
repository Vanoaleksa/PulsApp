
import UIKit
import SnapKit

class PulseTypeView: UIView {
    
    var updateType:((PulseType) -> ())?
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.adjusted)
        
        self.addSubview(label)
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupLayout()
        
        updateType = { type in
            DispatchQueue.main.async { [weak self] in
                self?.updateTypeHandler(type: type)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.layer.cornerRadius = 15.adjusted
    }
    
    private func setupLayout() {
        textLabel.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
    
    private func updateTypeHandler(type:PulseType) {
        switch type {
        case .fast:
            self.backgroundColor = UIColor(red: 226/255, green: 42/255, blue: 70/255, alpha: 0.2)
            self.textLabel.textColor = UIColor(red: 226/255, green: 42/255, blue: 70/255, alpha: 1)
            textLabel.text = "Fast pulse"
        case .normal:
            self.backgroundColor = UIColor(red: 33/255, green: 208/255, blue: 151/255, alpha: 0.2)
            self.textLabel.textColor = UIColor(red: 33/255, green: 208/255, blue: 151/255, alpha: 1)
            textLabel.text = "Normal pulse"
        case .slow:
            self.backgroundColor = UIColor(red: 47/255, green: 199/255, blue: 255/255, alpha: 0.2)
            self.textLabel.textColor = UIColor(red: 47/255, green: 199/255, blue: 255/255, alpha: 1)
            textLabel.text = "Slow pulse"
        }
    }
}
