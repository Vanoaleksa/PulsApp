
import UIKit
import SnapKit

final class QuickTestViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.text = "Quick Depression Test"
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
        label.text = "Use this short depression test to help determine if you have the symptoms of depression and whether you should seek a diagnosis or treatment for depression from a qualified doctor or mental health professional. This depression test is the Goldberg Depression Questionnaire."
        label.numberOfLines = 0
        label.textAlignment = .left
        
        view.addSubview(label)
        
        return label
    }()
    
    lazy var startTestButton: GlobalButton = {
        var button = GlobalButton()
        button.setTitle("Start test", for: .normal)
        button.addTarget(self, action: #selector(startTestAction), for: .touchUpInside)
        
        view.addSubview(button)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
    }
    
    private func configUI() {
        //Установка фонового изображения
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.9
        view.addSubview(imageView)
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        // Создание пользовательской кнопки "назад"
        let customBackButton = UIBarButtonItem(image: UIImage(named: "left-black-arrow-image"), style: .plain, target: self, action: #selector(goBackAction))
        customBackButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = customBackButton
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func goBackAction() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func startTestAction() {
        let nextVC = TestsQuestionsViewController()
        nextVC.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

//MARK: - Constraints
extension QuickTestViewController {
    private func setupLayout() {

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(95)
            make.leading.equalToSuperview().offset(18)
            make.width.equalToSuperview().dividedBy(1.65)
        }
        
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(18)
            make.trailing.equalTo(-18)
            make.height.equalTo(190)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(10)
            make.leading.equalTo(18)
            make.trailing.equalTo(-18)
            make.height.equalTo(120)
        }
        
        startTestButton.snp.makeConstraints { make in
            make.bottom.equalTo(-70)
            make.height.equalTo(68)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
    }
}
