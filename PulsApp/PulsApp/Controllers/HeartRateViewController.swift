
import UIKit
import SnapKit
import AVFoundation
import RealmSwift

class HeartRateViewController: UIViewController {
    
    var progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 210.adjusted, height: 210.adjusted))
    var heartViewModel: BindWithHeartControllerProtocol?
    var reusableView = ReusableAlertView(alertType: .camera)
    var privacyView = ReusableAlertView(alertType: .preview)
    var heartRateManager: HeartRateManager!
    var bpmForCalculating: [Int] = []
    var validFrameCounter = 0
    var timer = Timer()
    var timerTwo = Timer()
    var measurementStartedFlag = false
    var darkView: UIVisualEffectView?
    public weak var typesDelegate: TypesDelegate?
    
    // detection alghoritm
    var pulseDetector = PulseDetector()
    var inputs: [CGFloat] = []
    var hueFilter = Filter()
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Heart rate"
        let customFont = UIFont(name: "SFProDisplay-Bold", size: 28.adjusted)
        label.font = customFont
        label.textColor = .black
        
        view.addSubview(label)
        
        return label
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Info-button"), for: .normal)
        
        view.addSubview(button)
        
        return button
    }()
    
    lazy var fingersLabel: UILabel = {
        var label = UILabel()
        label.text = "No fingers"
        label.textColor = .black
        
        view.addSubview(label)
        
        return label
    }()
    
    lazy var clueLabel: UILabel = {
        var label = UILabel()
        label.text = "Place your finger on the back camera and flashlight"
        label.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 1)
        label.font = .systemFont(ofSize: 16.adjusted)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        view.addSubview(label)
        
        return label
    }()
    
    lazy var startButton: GlobalButton = {
        var button = GlobalButton()
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(startPulsHeartRate), for: .touchUpInside)
        
        view.addSubview(button)
        
        return button
    }()
    
    lazy var bpmImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Heart-ritm")
        
        view.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var tutorialImage: UIImageView = {
        let tutorialImage = UIImageView()
        tutorialImage.image = UIImage(named: "tutorial")
        
        view.addSubview(tutorialImage)
        
        return tutorialImage
    }()
    
    lazy var leftNumbersImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "left-numbers")
        
        view.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var scheduleLineImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "scheduleLineImage")
        
        view.addSubview(imageView)
        
        return imageView
    }()
    
    func heartBeatAnimation(){
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 1.0
        pulse.toValue = 1.12
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 0.8
        DispatchQueue.main.async {[weak self] in
            self?.progressView.heartImageView.layer.add(pulse, forKey: nil)
        }
    }
    
    func stopHeartBeatAnimation(){
        DispatchQueue.main.async {[weak self] in
            self?.progressView.heartImageView.layer.removeAllAnimations()
            self?.progressView.heartImageView.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkingIsFirstLaunch()
        configUI()
        setupLayout()
        heartViewModel = HeartRateViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clueLabel.isHidden = true
        tutorialImage.isHidden = true
        startButton.isHidden = false
        bpmImage.isHidden = false
        leftNumbersImage.isHidden = true
        scheduleLineImage.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deinitCaptureSession()
    }
    
    //MARK: - Setup UI
    private func configUI() {
        //Установка фонового изображения
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.9
        view.addSubview(imageView)
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        //Настройка progressView
        view.addSubview(progressView)
        progressView.createCircleShape()
    }
    
    private func checkingIsFirstLaunch() {
        // Проверяем, был ли уже выполнен первый вход
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
        
        if !isFirstLaunch {
            // Если это первый вход, показываем welcome View
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.showWelcomeView()
            }
            
            // Устанавливаем флаг, что первый вход уже выполнен
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
        }
    }
    
    @objc func startPulsHeartRate() {
        
        if UserManager.getUser() == nil {
            heartViewModel?.showAboutMeViewController(heartController: self)
        } else {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == AVAuthorizationStatus.authorized{
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else {return}
                    
                    initStartPulse()
                }
            } else {
                completedAboutMeStage()
            }
        }
    }
    
    func startPulseAnimation(){
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            leftNumbersImage.isHidden = false
            clueLabel.text = "Testing, keep your finger steady"
            clueLabel.isHidden = false
            tutorialImage.isHidden = true
            bpmImage.isHidden = true
            scheduleLineImage.isHidden = false
            progressView.shapeLayer.isHidden = false
            startButton.isHidden = true
        }
    }
    
    func stopPulseAnimation(){
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            leftNumbersImage.isHidden = true
            clueLabel.text = "Place your finger on the back camera and flashlight"
            clueLabel.isHidden = false
            tutorialImage.isHidden = false
            bpmImage.isHidden = true
            scheduleLineImage.isHidden = true
            startButton.isHidden = true
        }
    }
    
    private func initStartPulse(){
        initVideoCapture()
        initCaptureSession()
    }
}

extension HeartRateViewController: AlertViewDelegate, TypesDelegate, ResultViewDelegate {
    
    func tappedActionInPrivacyView(forType type: ALertType) {
        switch type {
        case .preview:
            hideAlertViewWithAnimation()
            self.darkView?.removeFromSuperview()
        case .camera:
            hideAlertViewWithAnimation()
            self.darkView?.removeFromSuperview()
            
            //Получаем доступ к камере
            let authorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authorizationStatus {
            case .authorized:
                initStartPulse()
            case .notDetermined:
                _ = UserDefaults.standard.bool(forKey: "cameraAccessGranted")
                // Пользователь еще не принял решение по поводу доступа к камере
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { [weak self] granted in
                    if granted {
                        // Доступ к камере был предоставлен
                        UserDefaults.standard.set(true, forKey: "cameraAccessGranted")
                        DispatchQueue.main.async {
                            self?.fingersLabel.isHidden = false
                            self?.startButton.isHidden = true
                            self?.tutorialImage.isHidden = false
                            self?.clueLabel.isHidden = false
                        }
                        self?.initStartPulse()
                    }
                }
                
            case .denied, .restricted:
                //Повторный зарос к пользователю, в случае отказа доступа к камере
                let alert = UIAlertController(title: "Error", message: "Camera access required to...", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .default))
                alert.addAction(UIAlertAction(title: "Settings", style: .cancel) { (alert) -> Void in
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(settingsURL) {
                            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                        }
                    }
                })
                
                present(alert, animated: true)
                
            default: break
            }
        }
    }
    
    func completedAboutMeStage() {
        let userInfo = UserModel()
        
        if userInfo.showCameraAccess != true {
            showCameraAccessView()
        } else {
            let alert = UIAlertController(title: NSLocalizedString("No access to camera", comment: ""),
                                          message: NSLocalizedString("please allow access to the camera", comment: ""),
                                          preferredStyle: .alert)
            
            let actionOK = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil)
            alert.addAction(actionOK)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func finalDefinitionType(type: AnalyzeTypes) {
        heartViewModel?.handleAnalyzeType(type: type)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.heartViewModel?.showResultView(heartController: self)
        }
    }
    
    func saveToDBAndCloseResultView() {
        self.darkView?.removeFromSuperview()
        heartViewModel?.saveBPMSettingsToDB()
    }
}
