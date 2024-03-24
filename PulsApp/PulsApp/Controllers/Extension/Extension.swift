

import Foundation
import UIKit
import AVKit

extension HeartRateViewController{
    
    func initVideoCapture(){  //иллюстрирует инициализацию захвата видео с камеры устройства, создание объекта HeartRateManager с заданными параметрами и установку обработчика изображений для каждого                                                                                                                                                                    кадра видео.
        let specs = VideoSpec(fps: 60, size: CGSize(width: 50, height: 50))
        heartRateManager = HeartRateManager(cameraType: .back, preferredSpec: specs, previewContainer: CAShapeLayer())
        heartRateManager?.imageBufferHandler = { [unowned self] (imageBuffer) in
            self.handle(buffer: imageBuffer)
        }
    }
    
    func initCaptureSession(){
        heartRateManager?.startCapture()
    }
    
    func deinitCaptureSession(){
        if heartRateManager != nil{
            heartRateManager.stopCapture()
            toggleTorch(status: false)
        }
    }
    
    func toggleTorch(status: Bool){ // Эта функция включает или выключает вспышку на устройстве для освещения съемки видео.
        guard let device = AVCaptureDevice.default(for: .video) else {return}
        device.toggleTorch(on: status)
    }
    
    func startMeasurement(){
        DispatchQueue.main.async {
//            self.bpmForCalculating.removeAll()
            self.toggleTorch(status: true)
            self.startPulseAnimation()
            self.progressView.startAniamation()
//            self.progressView.animation(duration: 20)
            var count = 20
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (timer) in //создаем таймер, который будет запускаться каждую секунду и выполнять блок кода
                guard let self = self else {return}
                
                if count > 0{
                    count -= 1
                    self.heartBeatAnimation()
                    self.fingersLabel.text = "\(count) " + NSLocalizedString("seconds remaining", comment: "")
                    let average = self.pulseDetector.getAverage()
                    let pulse = 60.0 / average
                    print ("pulse: \(pulse)")
                    
                    if pulse != -60{
                        self.progressView.pulseLabel.text = "\(lroundf(pulse))"
                        self.bpmForCalculating.append(Int(pulse))
                    }
                }else{
                    if self.bpmForCalculating != [] {
                        self.heartViewModel?.calculateAndSaveBPMDataToDB(pulse: self.bpmForCalculating)
                        self.heartViewModel?.showAnalyzeVC(heartController: self)
                    }
                    defaultState()
                }
            })
        }
    }
    
    func defaultState(){
        print("defaultstate")
        fingersLabel.isHidden = true
        fingersLabel.text = "No Fingers"
//        crookedLineImage.isHidden = false
        tutorialImage.isHidden = true
        startButton.isHidden = false
        progressView.pulseLabel.text = "00"
        clueLabel.isHidden = true
        toggleTorch(status: false)
//        self.progressBar.deleteAnimation()
        self.heartRateManager?.stopCapture()
        self.stopHeartBeatAnimation()
        self.progressView.deleteAnimations()
        bpmImage.isHidden = false
//        self.scheduleLineImage.isHidden = true
//        progressBar.miniProgressLayer.isHidden = true
//        progressBar.miniCircleContainerLayer.isHidden = true
        timer.invalidate()
    }
    
    func handle(buffer: CMSampleBuffer) {
        var redmean:CGFloat = 0.0
        var greenmean:CGFloat = 0.0
        var bluemean:CGFloat = 0.0
        
        let pixelBuffer = CMSampleBufferGetImageBuffer(buffer)
        let cameraImage = CIImage(cvPixelBuffer: pixelBuffer!)
        
        let extent = cameraImage.extent
        let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
        let averageFilter = CIFilter(name: "CIAreaAverage",
                                     parameters: [kCIInputImageKey: cameraImage, kCIInputExtentKey: inputExtent])!
        let outputImage = averageFilter.outputImage!
        
        let ctx = CIContext(options:nil)
        let cgImage = ctx.createCGImage(outputImage, from:outputImage.extent)!
        
        let rawData:NSData = cgImage.dataProvider!.data!
        let pixels = rawData.bytes.assumingMemoryBound(to: UInt8.self)
        let bytes = UnsafeBufferPointer<UInt8>(start:pixels, count:rawData.length)
        var BGRA_index = 0
        for pixel in UnsafeBufferPointer(start: bytes.baseAddress, count: bytes.count) {
            switch BGRA_index {
            case 0:
                bluemean = CGFloat (pixel)
            case 1:
                greenmean = CGFloat (pixel)
            case 2:
                redmean = CGFloat (pixel)
            case 3:
                break
            default:
                break
            }
            BGRA_index += 1
        }
        
        let hsv = rgb2hsv((red: redmean, green: greenmean, blue: bluemean, alpha: 1.0))
        // Do a sanity check to see if a finger is placed over the camera
        if (hsv.1 > 0.5 && hsv.2 > 0.5) {
            
            DispatchQueue.main.async {
                self.toggleTorch(status: true)
                if !self.measurementStartedFlag {
                    self.startMeasurement()
                    self.measurementStartedFlag = true
                }
            }
            validFrameCounter += 1
            inputs.append(hsv.0)
            // Filter the hue value - the filter is a simple BAND PASS FILTER that removes any DC component and any high frequency noise
            let filtered = hueFilter.processValue(value: Double(hsv.0))
            if validFrameCounter > 60 {
                _ = self.pulseDetector.addNewValue(newVal: filtered, atTime: CACurrentMediaTime())
            }
        } else {
            self.timer.invalidate()
            
            validFrameCounter = 0
            measurementStartedFlag = false
            pulseDetector.reset()
            
            DispatchQueue.main.async {
                self.stopPulseAnimation()
                self.stopHeartBeatAnimation()
                self.fingersLabel.text = NSLocalizedString("No fingers", comment: "")
                self.progressView.pulseLabel.text = "00"
                self.progressView.deleteAnimations()
            }
        }
    }
    
    func showWelcomeView(){
        setupDarkView()
        reusableView = ReusableAlertView(alertType: .preview)
//        reusableView.delegate = self
//        reusableView.darkView = self.darkView  //передача закрытия darkView через слабую ссылку
        self.tabBarController?.view.addSubview(reusableView)
        
        let height = 335
        reusableView.frame = CGRect(x: 0, y: self.tabBarController!.view.frame.height, width: self.tabBarController!.view.frame.width, height: CGFloat(height))
        self.tabBarController?.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.reusableView.frame.origin.y -= CGFloat(height)
        })
    }
    
    func showCameraAccessView(){
        setupDarkView()
        reusableView = ReusableAlertView(alertType: .camera)
        reusableView.delegate = self
//        reusableView.darkView = self.darkView // передача закрытия darkView через слабую ссылку
        self.tabBarController?.view.addSubview(reusableView)
        
        let height = 335
        reusableView.frame = CGRect(x: 0, y: self.tabBarController!.view.frame.height, width: self.tabBarController!.view.frame.width, height: CGFloat(height))
        self.tabBarController?.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.reusableView.frame.origin.y -= CGFloat(height)
        })
    }
    
    func hideAlertViewWithAnimation(){
        let height = 335
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.reusableView.frame.origin.y += CGFloat(height)
        }) { _ in
            self.reusableView.removeFromSuperview()
        }
    }
    
    private func setupDarkView(){
        let blurEffect = UIBlurEffect(style: .regular)
        darkView = UIVisualEffectView(effect: blurEffect)
        darkView?.frame = view.bounds
        darkView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let darkView = darkView{
            view.addSubview(darkView)
        }
    }
    
    //MARK: - Constraints
    func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.top.equalTo(view.snp.topMargin).offset(20)
        }
        
        infoButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-18)
        }
        
        fingersLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressView.snp.top).offset(-50)
            make.height.equalTo(20)
        }
        
        progressView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(220.adjusted)
            make.height.equalTo(220.adjusted)
            make.bottom.equalTo(view.snp.centerY).offset(13)
        }
        
        bpmImage.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(30.adjusted)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
//            make.height.equalTo(70.adjusted)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-50.adjusted)
            make.left.equalToSuperview().offset(40.adjusted)
            make.right.equalToSuperview().offset(-40.adjusted)
            make.centerX.equalToSuperview()
        }
        
        clueLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(40.adjusted)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        
        tutorialImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-160.adjusted)
        }
    }
}
