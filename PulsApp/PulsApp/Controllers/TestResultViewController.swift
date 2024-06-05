
import UIKit
import SnapKit

final class TestResultViewController: UIViewController {
    
    private let stateView = StateAfterTestView()
    var distanceForTriangle = 0
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.text = "Result"
        label.numberOfLines = 0
        
        view.addSubview(label)
        
        return label
    }()
    
    lazy var mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "testVC-image")
        imageView.layer.cornerRadius = 15
        
        view.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "Your depression test score is above and indicates whether or not you are suffering from depression symptoms usually associated with various forms of depression including major depression and bipolar disorder.\n\nThese symptoms can cause problems in everyday life."
        label.numberOfLines = 0
        label.textAlignment = .left
        
        view.addSubview(label)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
        stateView.setDistanceForTriangle(distanceForTriangle)
    }
    
    private func configUI() {
        //Установка фонового изображения
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.9
        view.addSubview(imageView)
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        view.addSubview(stateView)
        
        // Создание пользовательской кнопки "назад"
        self.navigationItem.hidesBackButton = true
        let customBackButton = UIBarButtonItem(image: UIImage(named: "left-black-arrow-image"), style: .plain, target: self, action: #selector(goBackAction))
        customBackButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = customBackButton
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func goBackAction() {
        self.navigationController?.popToRootViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}

//MARK: - Constraints
extension TestResultViewController {
    private func setupLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(95)
            make.leading.equalToSuperview().offset(18)
            make.width.equalToSuperview().dividedBy(1.65)
        }
        
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.equalTo(18)
            make.trailing.equalTo(-18)
            make.height.equalTo(190)
        }
        
        stateView.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(30)
            make.leading.equalTo(18)
            make.trailing.equalTo(-18)
            make.height.equalTo(100)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(stateView.snp.bottom).offset(15)
            make.leading.equalTo(18)
            make.trailing.equalTo(-18)
            make.height.equalTo(155)
        }
    }
}





