import UIKit
import SnapKit

final class DotFilledLabelView: UIView {
    
    private let leftLabel = UILabel()
    private let dotsLabel = UILabel()
    private let rightLabel = UILabel()
    
    init(frame: CGRect, leftLabelText: String, rightLabelText: String) {
        super.init(frame: .zero)
        setupView()
        setupLabels(leftLabelText: leftLabelText, rightLabelText: rightLabelText)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupLabels(leftLabelText: "", rightLabelText: "")
        setupLayout()
    }
    
    private func setupView() {
        addSubview(leftLabel)
        addSubview(dotsLabel)
        addSubview(rightLabel)
        
        setupDotLabel()
    }
    
    private func setupLabels(leftLabelText: String, rightLabelText: String) {
        leftLabel.text = leftLabelText
        leftLabel.textAlignment = .left
        leftLabel.textColor = .black
        leftLabel.font = .systemFont(ofSize: 14, weight: .light)
        
        rightLabel.text = rightLabelText
        rightLabel.textAlignment = .right
        rightLabel.textColor = .black
        rightLabel.font = .systemFont(ofSize: 14, weight: .light)

    }
    
    private func setupDotLabel() {
        dotsLabel.text = "" // Начальное значение
        dotsLabel.textAlignment = .right
        dotsLabel.font = .systemFont(ofSize: 14, weight: .light)
        fillDots()
    }
    
    private func fillDots() {
        let maxDots = 100
        let dots = String(repeating: ".", count: maxDots)
        dotsLabel.text = dots
        dotsLabel.adjustsFontSizeToFitWidth = true
        dotsLabel.minimumScaleFactor = 0.1
        dotsLabel.lineBreakMode = .byClipping
    }
    
    private func setupLayout() {
        
        leftLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        rightLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        dotsLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftLabel.snp.trailing).offset(3)
            make.trailing.equalTo(rightLabel.snp.leading).offset(-3)
            make.centerY.equalToSuperview()
        }
    }
}


