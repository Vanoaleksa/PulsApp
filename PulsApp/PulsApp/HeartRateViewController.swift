//
//  HeartViewController.swift
//  PulsApp
//
//  Created by MacBook on 1.03.24.
//

import UIKit
import SnapKit

class HeartRateViewController: UIViewController {
    
    var progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 220, height: 220))
//    var progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: self.view.snp.he, height: <#T##Int#>))
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Heart rate"
        let customFont = UIFont(name: "SFProDisplay-Bold", size: 28)
        label.font = customFont
        
        view.addSubview(label)
        
        return label
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Info-button"), for: .normal)
        
        view.addSubview(button)
        
        return button
    }()
    
    lazy var statusLabel: UILabel = {
        var label = UILabel()
        label.text = "No fingers"
        
        view.addSubview(label)
        
        return label
    }()
    
    lazy var startButton: UIButton = {
        var button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 32
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.backgroundColor = UIColor(red: 102/255, green: 118/255, blue: 250/255, alpha: 1)
        button.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        
        view.addSubview(button)
        
        return button
    }()
    
    lazy var heartRitmImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Heart-ritm")
        
        view.addSubview(imageView)
        
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
//MARK: - Setup UI
    private func configUI() {
        //Установка фонового изображения
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        
        //Настройка progressView
        view.addSubview(progressView)
        progressView.createCircleShape()
        
    }
    
    @objc func startAction() {
        progressView.startAniamation()
    }
}

extension HeartRateViewController {
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.top.equalTo(view.snp.topMargin).offset(20)
        }
        
        infoButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-18)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressView.snp.top).offset(-50)
            make.height.equalTo(20)
        }
        
        progressView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
            make.height.equalTo(220)
            make.bottom.equalTo(view.snp.centerY).offset(13)
        }
        
        heartRitmImage.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(30)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-50)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
    }
}
