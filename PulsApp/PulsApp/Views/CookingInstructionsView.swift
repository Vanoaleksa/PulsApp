
import UIKit
import SnapKit

final class CookingInstructionsView: UIView {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Cooking Instructions"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        
        self.addSubview(label)
        
        return label
    }()
    
    // Создаем стек
    let stackView = UIStackView()
    
    // Лейблы
    let labelsTexts = ["1. Slice the bacon thinly.",
                       "2. Put bacon in a skillet without oil.",
                       "3. Fry the bacon until crisp on both sides.",
                       "4. Break the eggs. Season with salt and pepper.",
                       "5. Fry until tender."
    ]
    
    var labelsArr: [UILabel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        for text in labelsTexts {
            let label = UILabel()
            label.text = text
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 14, weight: .light)
            label.textColor = .black
            stackView.addArrangedSubview(label)
            labelsArr.append(label)
        }
    }
    
    private func setupLayout() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(24)
            make.leading.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
}
