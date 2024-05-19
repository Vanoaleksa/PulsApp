
import UIKit
import SnapKit

final class DietViewController: UIViewController {
    
    private let mealsArr = ["Breakfast", "Lunch", "Dinner"]
    
    let breakFastArr = DishModel.fetchBreakfastDishes()
    let lunchArr = DishModel.fetchLunchDishes()
    let dinnerArr = DishModel.fetchDinnerDishes()
        
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView( frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        
        view.addSubview(collectionView)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
    }
    
    private func configUI () {
        //Установка фонового изображения
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        
        collectionView.register(MealsCollectionViewCell.self,
                                forCellWithReuseIdentifier: "\(MealsCollectionViewCell.self)")
    }
}

//MARK: - UICollectionViewDataSource
extension DietViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mealsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MealsCollectionViewCell.self)", for: indexPath) as! MealsCollectionViewCell
        
        let item = mealsArr[indexPath.row]
        let mealsArr = [breakFastArr, lunchArr, dinnerArr]
        
        cell.titleLabel.text = item.description
        cell.dishesArr = mealsArr[indexPath.row]
        cell.delegate = self
                
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension DietViewController: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DietViewController: UICollectionViewDelegateFlowLayout {
    //Setup a height to cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 3.6)
    }
}

//MARK: - MealsCollectionViewCellDelegate
extension DietViewController: MealsCollectionViewCellDelegate {
    func didTapSeeAllButton(with dishes: [DishModel]) {
        let mealsVC = MealsViewController()
        mealsVC.modalPresentationStyle = .fullScreen
        mealsVC.currentsDishes = dishes
        self.present(mealsVC, animated: true)
    }
}

//MARK: - Constraints
extension DietViewController {
    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
