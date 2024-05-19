
import UIKit
import SnapKit

final class MealsViewController: UIViewController {
    
    var currentsDishes: [DishModel]?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView( frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
        
        return collectionView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.text = "Breakfast"
        
        view.addSubview(label)
        
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "left-black-arrow-image"), for: .normal)
        button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        
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
        view.addSubview(imageView)
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        
        collectionView.register(DishesCollectionViewCell.self, forCellWithReuseIdentifier: "\(DishesCollectionViewCell.self)")
    }
    
    @objc func goBackAction() {
        self.dismiss(animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension MealsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentsDishes != nil ? currentsDishes!.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DishesCollectionViewCell.self)", for: indexPath) as! DishesCollectionViewCell
        
        guard currentsDishes != nil else {return cell}
        
        let item = currentsDishes![indexPath.row]
        
        cell.mainImage.image = item.mainImage
        cell.dishNameLabel.text = item.dishName
        cell.cookingTimeLabel.text = item.cookingTime
        cell.kkalLabel.text = item.kkal
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MealsViewController: UICollectionViewDelegateFlowLayout {
    //Setup a height to cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 2.1, height: collectionView.bounds.height / 3.5)
    }
}

//MARK: - UICollectionViewDelegate
extension MealsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = DishRecipeViewController()
        nextVC.modalPresentationStyle = .fullScreen
        
        let currentDish: DishModel
        
        currentDish = currentsDishes![indexPath.row]
        nextVC.currentDish = currentDish
        self.present(nextVC, animated: true)
    }
}

//MARK: - Constraints
extension MealsViewController {
    private func setupLayout() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.leading.equalToSuperview().offset(18)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(18)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}
