
import UIKit
import SnapKit
import AVFoundation
import RealmSwift

class HeartRateViewController: UIViewController {
    
    var progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 214.adjusted, height: 214.adjusted))
    var heartViewModel: BindWithHeartControllerProtocol?
    var reusableView = ReusableAlertView(alertType: .camera)
    var heartRateManager: HeartRateManager!
    var bpmForCalculating: [Int] = []
    var validFrameCounter = 0
    var timer = Timer()
    var timerTwo = Timer()
    var measurementStartedFlag = false
    var darkView: UIVisualEffectView?

    // detection alghoritm
    var pulseDetector = PulseDetector()
    var inputs: [CGFloat] = []
    var hueFilter = Filter()
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Heart rate"
        let customFont = UIFont(name: "SFProDisplay-Bold", size: 28.adjusted)
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
    
    lazy var fingersLabel: UILabel = {
        var label = UILabel()
        label.text = "No fingers"
        
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deinitCaptureSession()
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
    
    @objc func startPulsHeartRate() {
        
        if UserManager.getUser()?.aboutMeWasShow == false {
                        heartViewModel?.showAboutMeViewController(heartController: self)
        }
        
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == AVAuthorizationStatus.authorized{
            DispatchQueue.main.async {[weak self] in
                guard let self = self else {return}
                
                initStartPulse()
            }
        }else{
            completedAboutMeStage()
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

extension HeartRateViewController: AlertViewDelegate {
   
    func tappedActionInPrivacyView(forType type: ALertType) {
        print("testtapped")
        switch type {
        case .preview:
            hideAlertViewWithAnimation()
//            self.reusableView.darkView?.removeFromSuperview()
        case .camera:
            hideAlertViewWithAnimation()
//            self.reusableView.darkView?.removeFromSuperview()
            
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { [unowned self] response in
                if response{
                    DispatchQueue.main.async {
                        self.fingersLabel.isHidden = false
                        self.startButton.isHidden = true
                        self.tutorialImage.isHidden = false
                        self.clueLabel.isHidden = false
                    }
                    self.initStartPulse()
                }
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
    
    func finalDefinitionType(types: AnalyzeTypes) {
        heartViewModel?.handleAnalyzeType(type: types)
        heartViewModel?.showResultView(heartController: self)
    }
    
    func closeResultViewAndSaveToDB() {
        heartViewModel?.saveBPMSettingsToDB()
        tabBarController?.tabBar.isHidden = false
    }
}
