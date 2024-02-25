//
//  ViewController.swift
//  PulsApp
//
//  Created by MacBook on 22.02.24.
//

import UIKit
import SnapKit

class AboutMeViewController: UIViewController {
    
    var tableViewController = UITableViewController(style: .plain)
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "About me"
        let customFont = UIFont(name: "SFProDisplay-Bold", size: 28)
        label.font = customFont
        
        view.addSubview(label)
        
        return label
    }()
    
    lazy var europeanMesasuringButton: UIButton = {
        var button = UIButton()
        button.setTitle("Cm, Kg", for: .normal)
        button.setTitleColor(UIColor(red: 102/255, green: 118/255, blue: 250/255, alpha: 1), for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.layer.borderColor = CGColor(red: 102/255, green: 118/255, blue: 250/255, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(europeanMesasuringButtonAction), for: .touchUpInside)
        button.isSelected = true
        
        
        button.backgroundColor = UIColor(red: 102/255, green: 118/255, blue: 250/255, alpha: 1)

        view.addSubview(button)

        return button
    }()
    
    lazy var americanMesasuringButton: UIButton = {
        var button = UIButton()
        button.setTitle("In, Lbs", for: .normal)
        button.setTitleColor(UIColor(red: 102/255, green: 118/255, blue: 250/255, alpha: 1), for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.layer.borderColor = CGColor(red: 102/255, green: 118/255, blue: 250/255, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(americanMesasuringButtonAction), for: .touchUpInside)
        button.isSelected = false
        
        button.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)

        view.addSubview(button)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        createTableView()
        setupLayout()
    }
    
//MARK: - Setup UI
    func configUI() {
        
        //Установка фонового изображения
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
//        view.sendSubviewToBack(imageView)
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        
        tableViewController.tableView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        
        
    }
    
//MARK: - Создание tableView
    private func createTableView() {
        tableViewController.tableView.register(CustomGenderCell.self, forCellReuseIdentifier: "GenderCell")
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
        
        view.addSubview(tableViewController.tableView)
    }
    
    @objc func europeanMesasuringButtonAction() {
        europeanMesasuringButton.isSelected = true
        americanMesasuringButton.isSelected = false
        europeanMesasuringButton.backgroundColor = UIColor(red: 102/255, green: 118/255, blue: 250/255, alpha: 1)
        americanMesasuringButton.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
        
    }
    
    @objc func americanMesasuringButtonAction() {
        americanMesasuringButton.isSelected = true
        europeanMesasuringButton.isSelected = false
        americanMesasuringButton.backgroundColor = UIColor(red: 102/255, green: 118/255, blue: 250/255, alpha: 1)
        europeanMesasuringButton.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
    }
    
    
}

extension AboutMeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let genderCell = tableView.dequeueReusableCell(withIdentifier: "GenderCell", for: indexPath)
            genderCell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
            genderCell.selectionStyle = .none
            
//            genderCell.contentView.frame = genderCell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1))
            
            return genderCell
        } else {
            let genderCell = tableView.dequeueReusableCell(withIdentifier: "GenderCell", for: indexPath)
            
//            genderCell.contentView.frame = genderCell.contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right:0))
            
            return genderCell
        }
        
        
    }
    
    
}

extension AboutMeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51.0
    }
    
  
}



//MARK: - Setup constraints
extension AboutMeViewController {
    func setupLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(74)
        }
        
        europeanMesasuringButton.snp.makeConstraints { make in
            make.top.equalTo(138)
            make.left.equalTo(87)
            make.width.equalTo(94)
            make.height.equalTo(31)
        }
        
        americanMesasuringButton.snp.makeConstraints { make in
            make.top.equalTo(138)
            make.left.equalTo(195)
            make.height.equalTo(31)
            make.width.equalTo(94)
        }
        
        tableViewController.tableView.snp.makeConstraints { make in
            make.top.equalTo(187)
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.height.equalTo(250)
        }
    }
}

