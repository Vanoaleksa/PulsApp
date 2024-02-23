//
//  ViewController.swift
//  PulsApp
//
//  Created by MacBook on 22.02.24.
//

import UIKit
import SnapKit

class AboutMeViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "About me"
        let customFont = UIFont(name: "SFProDisplay-Bold", size: 28)
        label.font = customFont
        
        view.addSubview(label)
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
//MARK: - Setup UI
    func configUI() {
        
        //Установка фонового изображения
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        
    }
    
}

//MARK: - Setup constraints
extension AboutMeViewController {
    func setupLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(74)
        }
    }
}

