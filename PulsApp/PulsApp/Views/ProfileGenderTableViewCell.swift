
import UIKit
import SnapKit

final class ProfileGenderTableViewCell: UITableViewCell {

    private var gendersStack: UIStackView!
    private var maleView: GenderFieldView!
    private var femaleView: GenderFieldView!
    public var genderIsSelected: Gender = .male {
        didSet{
            if genderIsSelected == .male {
                maleView.changeStateSelected(isSelected: true)
                femaleView.changeStateSelected(isSelected: false)
            } else{
                maleView.changeStateSelected(isSelected: false)
                femaleView.changeStateSelected(isSelected: true)
            }
        }
    }
    
    private lazy var mainView: UIView = {
        var view = UIView()
        
        contentView.addSubview(view)
        
        return view
    }()
    
    private lazy var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gender-image")
        
        mainView.addSubview(imageView)
        
        return imageView
    }()
    
    private lazy var genderLabel: UILabel = {
        var label = UILabel()
        label.text = "Gender"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(red: 29/255, green: 29/255, blue: 37/255, alpha: 1)
        
        mainView.addSubview(label)
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "ProfileGenderTableViewCell")
        
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)

        mainView.backgroundColor = UIColor(red: 241/255, green: 240/255, blue: 245/255, alpha: 0.6)
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = CGColor(red: 226/255, green: 224/255, blue: 232/255, alpha: 1)
        mainView.layer.cornerRadius = 12
        
        gendersStack = UIStackView()
        gendersStack.spacing = 14
        
        maleView = GenderFieldView(gender: .male)
        femaleView = GenderFieldView(gender: .female)
        
        maleView.delegate = self
        femaleView.delegate = self
        
        genderIsSelected = .male
        
        mainView.addSubview(gendersStack)
        gendersStack.addArrangedSubview(maleView)
        gendersStack.addArrangedSubview(femaleView)
    }
}

//MARK: - Constrints
extension ProfileGenderTableViewCell {
    
    private func setupLayout() {
        
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(-10)
        }
        
        cellImage.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
        genderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(cellImage.snp.trailing).offset(12)
        }
        
        gendersStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-14.adjusted)
        }
        
        
    }
}

//MARK: - GenderCellDelegate
extension ProfileGenderTableViewCell: GenderCellDelegate{
    
    func tapOnChooseGenderField(gender: Gender) {
        self.genderIsSelected = gender
    }
}
