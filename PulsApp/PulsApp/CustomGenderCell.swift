//
//  CustomGenderCell.swift
//  PulsApp
//
//  Created by MacBook on 25.02.24.
//

import UIKit
import SnapKit

class CustomGenderCell: UITableViewCell {
    
    lazy var genderLabel: UILabel = {
        var label = UILabel()
        label.text = "Gender"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(red: 29/255, green: 29/255, blue: 37/255, alpha: 1)
        label.textAlignment = .center
        
        contentView.addSubview(label)
        
        return label
    }()
    
    lazy var maleLabel: UILabel = {
        var label = UILabel()
        label.text = "Male"
//        label.font = UIFont(name: "SFProDisplay", size: 5)
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(red: 29/255, green: 29/255, blue: 37/255, alpha: 1)
        label.textAlignment = .center
        
        contentView.addSubview(label)
        
        return label
    }()
    
    lazy var femaleLabel: UILabel = {
        var label = UILabel()
        label.text = "Female"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(red: 29/255, green: 29/255, blue: 37/255, alpha: 1)
        label.textAlignment = .center
        
        contentView.addSubview(label)
        
        return label
    }()
    
    lazy var maleCheckBox: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "checkboxUnselected"), for: .normal)
        button.setImage(UIImage(named: "checkboxSelected"), for: .selected)
        button.addTarget(self, action: #selector(maleCheckboxAction), for: .touchUpInside)
        
        contentView.addSubview(button)
        
        return button
    }()
    
    lazy var femaleCheckBox: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "checkboxUnselected"), for: .normal)
        button.setImage(UIImage(named: "checkboxSelected"), for: .selected)
        button.addTarget(self, action: #selector(femaleCheckboxAction), for: .touchUpInside)
        
        contentView.addSubview(button)
        
        return button
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

        contentView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 249/255, alpha: 0.6)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = CGColor(red: 235/255, green: 233/255, blue: 240/255, alpha: 1)
        contentView.layer.cornerRadius = 12
        
    }
    
    @objc func maleCheckboxAction() {
        maleCheckBox.isSelected = true
        femaleCheckBox.isSelected = false
        maleLabel.textColor = UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 1)
        femaleLabel.textColor = UIColor(red: 29/255, green: 29/255, blue: 37/255, alpha: 1)
    }
    
    @objc func femaleCheckboxAction() {
        maleCheckBox.isSelected = false
        femaleCheckBox.isSelected = true
        femaleLabel.textColor = UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 1)
        maleLabel.textColor = UIColor(red: 29/255, green: 29/255, blue: 37/255, alpha: 1)
    }
}

extension CustomGenderCell {
    
    func setupLayout() {
        genderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
        }
        
        maleCheckBox.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(185)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        maleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(maleCheckBox.snp.right).offset(4)
            
        }
        
        femaleCheckBox.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(maleLabel.snp.right).offset(23)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        femaleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(femaleCheckBox.snp.right).offset(4)
        }
    }
}
