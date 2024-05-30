
import UIKit
import SnapKit

protocol GenderCellDelegate: AnyObject{
    func tapOnChooseGenderField(gender: Gender)
}

class CustomGenderCell: UITableViewCell {
    
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
    
    lazy var mainView: UIView = {
        var view = UIView()
        
        contentView.addSubview(view)
        
        return view
    }()
    
    lazy var genderLabel: UILabel = {
        var label = UILabel()
        label.text = "Gender"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(red: 29/255, green: 29/255, blue: 37/255, alpha: 1)
        
        mainView.addSubview(label)
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "GenderCell")
        
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        contentView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)

        mainView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 249/255, alpha: 0.6)
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = CGColor(red: 235/255, green: 233/255, blue: 240/255, alpha: 1)
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

extension CustomGenderCell {
    
    func setupLayout() {
        
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(-10)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
        }
        
        gendersStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-14.adjusted)
        }
    }
}

extension CustomGenderCell: GenderCellDelegate{
    
    func tapOnChooseGenderField(gender: Gender) {
        self.genderIsSelected = gender
    }
}
