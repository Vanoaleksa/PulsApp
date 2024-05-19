
import UIKit
import SnapKit

class DishRecipeViewController: UIViewController {
    
    var currentDish: DishModel?
    
    //Config circles
    let circlesStackView = UIStackView()
    
    let proteinProgressView = ProgressCirclesView(frame: CGRect(x: 0, y: 0, width: 64, height: 64),
                                                  progress: 0.2,
                                                  procentsLabelText: "16%",
                                                  nameLabelText: "Protein",
                                                  gramsLabelText: "18 g")
    
    let fatProgressView = ProgressCirclesView(frame: CGRect(x: 0, y: 0, width: 64, height: 64),
                                                  progress: 0.4,
                                                  procentsLabelText: "50%",
                                                  nameLabelText: "Fat",
                                                  gramsLabelText: "20 g")
    
    let carbsProgressView = ProgressCirclesView(frame: CGRect(x: 0, y: 0, width: 64, height: 64),
                                                  progress: 0.3,
                                                  procentsLabelText: "33%",
                                                  nameLabelText: "Carbs",
                                                  gramsLabelText: "40 g")
    
    
    let mainInfoView = MainInfoAboutDishView()
    let ingridientsView = IngridientsView()
    let cookingInstructionsView = CookingInstructionsView()
    
    lazy var mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Bacon and eggs  - image")
        imageView.layer.cornerRadius = 20
        
        view.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "left-white-arrow-image"), for: .normal)
        button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        
        view.addSubview(button)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLabels()
        setupLayout()
    }
    
    private func configUI() {
        view.backgroundColor = UIColor(red: 240/255, green: 242/255, blue: 248/255, alpha: 1)
        
        view.insertSubview(mainInfoView, aboveSubview: mainImage)
        
        //config circlesStackView
        circlesStackView.axis = .horizontal
        circlesStackView.distribution = .fillEqually
        view.addSubview(circlesStackView)
        
        circlesStackView.addArrangedSubview(proteinProgressView)
        circlesStackView.addArrangedSubview(fatProgressView)
        circlesStackView.addArrangedSubview(carbsProgressView)
        
        view.addSubview(ingridientsView)
        view.addSubview(cookingInstructionsView)
    }
    
    private func setupLabels() {
        if let currentDish = currentDish {
            mainImage.image = currentDish.mainImage
            mainInfoView.nameLabel.text = currentDish.dishName
            mainInfoView.cookingTimeLabel.text = currentDish.cookingTime
            mainInfoView.kkalLabel.text = currentDish.kkal
        }
    }
    
    @objc func goBackAction() {
        self.dismiss(animated: true)
    }
}

extension DishRecipeViewController {
    private func setupLayout() {
        mainImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2.9)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.leading.equalToSuperview().offset(18)
        }
        
        mainInfoView.snp.makeConstraints { make in
            make.centerY.equalTo(mainImage.snp.bottom)
            make.leading.equalToSuperview().offset(38)
            make.trailing.equalToSuperview().offset(-38)
            make.height.equalTo(126)
        }
        
        circlesStackView.snp.makeConstraints { make in
            make.top.equalTo(mainInfoView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(100)
        }
        
        ingridientsView.snp.makeConstraints { make in
            make.top.equalTo(circlesStackView.snp.bottom).offset(65)
            make.height.equalTo(120)
            make.leading.equalTo(19)
            make.trailing.equalTo(-19)
        }
        
        cookingInstructionsView.snp.makeConstraints { make in
            make.top.equalTo(ingridientsView.snp.bottom).offset(20)
            make.leading.equalTo(19)
            make.trailing.equalTo(-19)
            make.bottom.equalToSuperview()
        }
    }
}
