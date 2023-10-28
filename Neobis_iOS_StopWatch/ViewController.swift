//
//  ViewController.swift
//  Neobis_iOS_StopWatch
//
//  Created by Alikhan Tursunbekov on 17/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: Timer?
    var passedTime: TimeInterval = 0
    var stopWatchHours = 0
    var stopWatchMins = 0
    var stopWatchSecs = 0
    
    var isStarted = false
    
    var isTimer = true
    var counter = 1.0
    
    private lazy var hours = Array(0...23)
    private lazy var minutes = Array(0...59)
    private lazy var seconds = Array(0...59)
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    private lazy var timerImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "timer"))
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        return image
    }()
    
    private lazy var segmentController: UISegmentedControl = {
        let segmentController = UISegmentedControl(items: ["Timer", "Stopwatch"])
        segmentController.selectedSegmentIndex = 0
        return segmentController
    }()
    
    private lazy var timerText: UILabel = {
        let text = UILabel()
        text.text = "00:00:00"
        text.textAlignment = .center
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 70)
        return text
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var stopImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "stop.circle.fill"))
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        return image
    }()
    
    private lazy var startButton: UIButton =  {
        let button = UIButton()
        return button
    }()
    
    private lazy var startImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "play.circle.fill"))
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        return image
    }()
    
    private lazy var pauseButton: UIButton =  {
        let button = UIButton()
        return button
    }()
    
    private lazy var pauseImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "pause.circle.fill"))
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 248 / 255, green: 205 / 255, blue: 10 / 255, alpha: 1)
        setupConstraints()
        setupTargets()
        pickerView.isHidden = true
    }

    //All constraints
    private func setupConstraints() {
        view.addSubview(timerImage)
        view.addSubview(segmentController)
        view.addSubview(timerText)
        view.addSubview(stopButton)
        stopButton.addSubview(stopImage)
        view.addSubview(startButton)
        startButton.addSubview(startImage)
        view.addSubview(pauseButton)
        pauseButton.addSubview(pauseImage)
        view.addSubview(pickerView)
        
        [timerImage, segmentController, timerText, stopButton, stopImage, startButton, startImage, pauseButton, pauseImage, pickerView].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            timerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: heightD(20)),
            timerImage.widthAnchor.constraint(equalToConstant: heightD(100)),
            timerImage.heightAnchor.constraint(equalToConstant: heightD(100)),
            
            segmentController.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentController.topAnchor.constraint(equalTo: timerImage.bottomAnchor, constant: heightD(20)),
            
            timerText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerText.topAnchor.constraint(equalTo: segmentController.bottomAnchor, constant: heightD(50)),
            
            pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseButton.topAnchor.constraint(equalTo: timerImage.bottomAnchor, constant: heightD(450)),
            pauseButton.heightAnchor.constraint(equalToConstant: heightD(80)),
            pauseButton.widthAnchor.constraint(equalToConstant: heightD(80)),
            
            pauseImage.centerXAnchor.constraint(equalTo: pauseButton.centerXAnchor),
            pauseImage.centerYAnchor.constraint(equalTo: pauseButton.centerYAnchor),
            pauseImage.heightAnchor.constraint(equalToConstant: heightD(80)),
            pauseImage.widthAnchor.constraint(equalToConstant: heightD(80)),
            
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: widthD(-100)),
            stopButton.topAnchor.constraint(equalTo: timerImage.bottomAnchor, constant: heightD(450)),
            stopButton.heightAnchor.constraint(equalToConstant: heightD(80)),
            stopButton.widthAnchor.constraint(equalToConstant: heightD(80)),
            
            stopImage.centerXAnchor.constraint(equalTo: stopButton.centerXAnchor),
            stopImage.centerYAnchor.constraint(equalTo: stopButton.centerYAnchor),
            stopImage.heightAnchor.constraint(equalToConstant: heightD(80)),
            stopImage.widthAnchor.constraint(equalToConstant: heightD(80)),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: widthD(100)),
            startButton.topAnchor.constraint(equalTo: timerImage.bottomAnchor, constant: heightD(450)),
            startButton.heightAnchor.constraint(equalToConstant: heightD(80)),
            startButton.widthAnchor.constraint(equalToConstant: heightD(80)),
            
            startImage.centerXAnchor.constraint(equalTo: startButton.centerXAnchor),
            startImage.centerYAnchor.constraint(equalTo: startButton.centerYAnchor),
            startImage.heightAnchor.constraint(equalToConstant: heightD(80)),
            startImage.widthAnchor.constraint(equalToConstant: heightD(80)),
            
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupTargets() {
        segmentController.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        stopButton.addTarget(self, action: #selector(stopAction), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseAction), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        stopAction()
        if sender.selectedSegmentIndex == 0 {
            counter = 1
            isTimer = true
            pickerView.isHidden = true
            timerImage.image = UIImage(systemName: "timer")
        } else {
            counter = -1
            isTimer = false
            pickerView.isHidden = false
            timerImage.image = UIImage(systemName: "stopwatch")
        }
    }
    
    private func secondsToHoursMinutesSeconds(seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        return (hours, minutes, remainingSeconds)
    }
    
    @objc func updateTimer() {
        if !isTimer && passedTime == 0 {
            stopAction()
        } else {
            passedTime += counter
            
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .positional
            formatter.zeroFormattingBehavior = .pad
            
            if let formattedString = formatter.string(from: passedTime) {
                timerText.text = formattedString
            }
        }
    }
    
    @objc func stopAction() {
        timer?.invalidate()
        passedTime = 0
        timerText.text = "00:00:00"
        startImage.image = UIImage(systemName: "play.circle.fill")
        pauseImage.image = UIImage(systemName: "pause.circle.fill")
        isStarted = false
        
        if !isTimer {
            pickerView.isHidden = false
            pickerView.selectRow(0, inComponent: 0, animated: true)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            stopWatchHours = 0
            stopWatchMins = 0
            stopWatchSecs = 0
        }
    }
    
    @objc func pauseAction() {
        if passedTime == 0 {
            return
        }
        timer?.invalidate()
        pauseImage.image = UIImage(systemName: "pause.circle")
        startImage.image = UIImage(systemName: "play.circle.fill")
        isStarted = false
        
        if !isTimer {
            pickerView.isHidden = false
            let timeComponents = secondsToHoursMinutesSeconds(seconds: Int(passedTime))
            pickerView.selectRow(timeComponents.hours, inComponent: 0, animated: true)
            pickerView.selectRow(timeComponents.minutes, inComponent: 1, animated: true)
            pickerView.selectRow(timeComponents.seconds, inComponent: 2, animated: true)
        }
    }
    
    @objc func startAction() {
        if isStarted {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isStarted = true
        startImage.image = UIImage(systemName: "play.circle")
        pauseImage.image = UIImage(systemName: "pause.circle.fill")
        if !isTimer && timerText.text == "00:00:00" {
            passedTime = Double(stopWatchHours) * 3600.0 + Double(stopWatchMins) * 60.0 + Double(stopWatchSecs)
        }
        pickerView.isHidden = true
    }
    
    
    //For Dynamic Sizes
    private func heightD(_ num: Double) -> Double {
        return UIScreen.main.bounds.height * num / 896
    }
    
    private func widthD(_ num: Double) -> Double{
        return UIScreen.main.bounds.width * num / 414
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1:
            return minutes.count
        case 2:
            return seconds.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(hours[row])"
        case 1:
            return "\(minutes[row])"
        case 2:
            return "\(seconds[row])"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stopWatchHours = hours[pickerView.selectedRow(inComponent: 0)]
        stopWatchMins = minutes[pickerView.selectedRow(inComponent: 1)]
        stopWatchSecs = seconds[pickerView.selectedRow(inComponent: 2)]
    }
}
