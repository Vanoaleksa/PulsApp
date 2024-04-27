
import UIKit
import SnapKit

protocol TypesDelegate: AnyObject {
    func finalDefinitionType(type: AnalyzeTypes)
}

class AnalyzViewController: UIViewController {
    
    weak var delegate: TypesDelegate?
            
    let restingTypeButton = TypesView.init(type: .coffee,
                                     image: UIImageView(image: UIImage(named: "Resting-image")))
    let sleepTypeButton = TypesView.init(type: .sleep,
                                     image: UIImageView(image: UIImage(named: "Sleep-image")))
    let activeTypeButton = TypesView.init(type: .active,
                                     image: UIImageView(image: UIImage(named: "Active-image")))
    
    private var typeIsSelected: AnalyzeTypes = .coffee {
        didSet{
            if typeIsSelected == .coffee {
                restingTypeButton.typesChangeStateSelected(isSelected: true)
                sleepTypeButton.typesChangeStateSelected(isSelected: false)
                activeTypeButton.typesChangeStateSelected(isSelected: false)
            } else if typeIsSelected == .sleep {
                restingTypeButton.typesChangeStateSelected(isSelected: false)
                sleepTypeButton.typesChangeStateSelected(isSelected: true)
                activeTypeButton.typesChangeStateSelected(isSelected: false)
            } else {
                restingTypeButton.typesChangeStateSelected(isSelected: false)
                sleepTypeButton.typesChangeStateSelected(isSelected: false)
                activeTypeButton.typesChangeStateSelected(isSelected: true)
            }
        }
    }

    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Analyzing"
        let customFont = UIFont(name: "SFProDisplay-Bold", size: 28.adjusted)
        label.font = customFont
        label.textColor = .black
        
        view.addSubview(label)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "People have different heart rates in different states. Selecting the current state will effectively provide you with heart rate assessment analysis"
        let customFont = UIFont(name: "SFProDisplay", size: 16.adjusted)
        label.font = customFont
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        
        view.addSubview(label)
        
        return label
    }()
    
    lazy var continueButton: GlobalButton = {
        var button = GlobalButton()
        button.setTitle("Continue", for: .normal)
        button.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
        
        view.addSubview(button)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
        
        restingTypeButton.typesDelegate = self
        sleepTypeButton.typesDelegate = self
        activeTypeButton.typesDelegate = self
        
        typeIsSelected = .coffee
    }
    
    //MARK: - Setup UI
    private func configUI() {
        //Установка фонового изображения
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        
        view.addSubview(restingTypeButton)
        view.addSubview(activeTypeButton)
        view.addSubview(sleepTypeButton)
        
    }
    
    @objc func continueButtonAction() {
        self.dismiss(animated: true)
        
        delegate?.finalDefinitionType(type: typeIsSelected)
    }
    
    //MARK: - Setup layout
    private func setupLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18.adjusted)
            make.top.equalTo(view.snp.topMargin).offset(20.adjusted)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(60.adjusted)
            make.left.equalToSuperview().offset(18.adjusted)
            make.width.equalTo(300.adjusted)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-80.adjusted)
            make.left.equalToSuperview().offset(40.adjusted)
            make.right.equalToSuperview().offset(-40.adjusted)
            make.centerX.equalToSuperview()
        }
        
        restingTypeButton.snp.makeConstraints { make in
            make.left.equalTo(32.adjusted)
            make.centerY.equalToSuperview()
            make.width.equalTo(80.adjusted)
            make.height.equalTo(80.adjusted)
        }
        
        sleepTypeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(80.adjusted)
            make.height.equalTo(80.adjusted)
        }
        
        activeTypeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-32.adjusted)
            make.centerY.equalToSuperview()
            make.width.equalTo(80.adjusted)
            make.height.equalTo(80.adjusted)
        }
    }

}

extension AnalyzViewController: TypesDelegate {
    func finalDefinitionType(type: AnalyzeTypes) {
        self.typeIsSelected = type
    }
}
