
import UIKit
import SnapKit

class IngridientsView: UIView {

    private lazy var ingridientsLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredient list"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        self.addSubview(label)
        
        return label
    }()
    
    let ingridientsStackView = UIStackView()
    
    let firstIngridientLabel = DotFilledLabelView(frame: .zero, leftLabelText: "Chicken egg", rightLabelText: "4 pices")
    let secontIngridientLabel = DotFilledLabelView(frame: .zero, leftLabelText: "Bacon", rightLabelText: "100 g")
    let thirdIngridientLabel = DotFilledLabelView(frame: .zero, leftLabelText: "Salt", rightLabelText: "Pinch")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        //config circlesStackView
        ingridientsStackView.axis = .vertical
        ingridientsStackView.distribution = .fillEqually
//        ingridientsStackView.spacing = 10
        self.addSubview(ingridientsStackView)
        
        ingridientsStackView.addArrangedSubview(firstIngridientLabel)
        ingridientsStackView.addArrangedSubview(secontIngridientLabel)
        ingridientsStackView.addArrangedSubview(thirdIngridientLabel)
        
    }
    
    private func setupLayout() {
        ingridientsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(24)
            make.leading.equalToSuperview()
        }
        
        ingridientsStackView.snp.makeConstraints { make in
            make.top.equalTo(ingridientsLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}
