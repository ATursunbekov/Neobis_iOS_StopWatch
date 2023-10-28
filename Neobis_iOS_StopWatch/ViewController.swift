//
//  ViewController.swift
//  Neobis_iOS_StopWatch
//
//  Created by Alikhan Tursunbekov on 17/10/23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var timer: Timer?
    var elapsedTimeInSeconds: TimeInterval = 0
    var hour = 0
    var min = 0
    var sec = 0
    
    var isStarted = false
    
    var isTimer = true
    var counter = 1.0
    
    let hours = Array(0...23)
    let minutes = Array(0...59)
    let seconds = Array(0...59)
    
    var pickerView: UIPickerView!
    
    let timerImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "timer")
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let segmentController: UISegmentedControl = {
        let segmentController = UISegmentedControl(items: ["Timer", "Stopwatch"])
        segmentController.selectedSegmentIndex = 0
        segmentController.translatesAutoresizingMaskIntoConstraints = false
        return segmentController
    }()
    
    let timerText: UILabel = {
        let text = UILabel()
        text.text = "00:00:00"
        text.textAlignment = .center
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 70)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    var stopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var stopImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "stop.circle.fill"))
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    var startButton: UIButton =  {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var startImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "play.circle.fill")
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var pauseButton: UIButton =  {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var pauseImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "pause.circle.fill")
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 248 / 255, green: 205 / 255, blue: 10 / 255, alpha: 1)
        setupPicker()
        setupConstraints()
        setupTargets()
        pickerView.isHidden = true
    }

    //All constraints
    func setupConstraints() {
        view.addSubview(timerImage)
        view.addSubview(segmentController)
        view.addSubview(timerText)
        view.addSubview(stopButton)
        stopButton.addSubview(stopImage)
        view.addSubview(startButton)
        startButton.addSubview(startImage)
        view.addSubview(pauseButton)
        pauseButton.addSubview(pauseImage)
        
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
    
    func setupPicker() {
        pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerView)
    }
    
    func setupTargets() {
        segmentController.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        stopButton.addTarget(self, action: #selector(stopAction), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseAction), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        stopAction()
        if selectedIndex == 0 {
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
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        return (hours, minutes, remainingSeconds)
    }
    
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
        hour = hours[pickerView.selectedRow(inComponent: 0)]
        min = minutes[pickerView.selectedRow(inComponent: 1)]
        sec = seconds[pickerView.selectedRow(inComponent: 2)]
    }
    
    @objc func updateTimer() {
        if !isTimer && elapsedTimeInSeconds == 0 {
            stopAction()
        } else {
            elapsedTimeInSeconds += counter
            
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .positional
            formatter.zeroFormattingBehavior = .pad
            
            if let formattedString = formatter.string(from: elapsedTimeInSeconds) {
                timerText.text = formattedString
            }
        }
    }
    
    @objc func stopAction() {
        timer?.invalidate()
        elapsedTimeInSeconds = 0
        timerText.text = "00:00:00"
        startImage.image = UIImage(systemName: "play.circle.fill")
        pauseImage.image = UIImage(systemName: "pause.circle.fill")
        isStarted = false
        
        if !isTimer {
            pickerView.isHidden = false
            pickerView.selectRow(0, inComponent: 0, animated: true)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            hour = 0
            min = 0
            sec = 0
        }
    }
    
    @objc func pauseAction() {
        if elapsedTimeInSeconds == 0 {
            return
        }
        timer?.invalidate()
        pauseImage.image = UIImage(systemName: "pause.circle")
        startImage.image = UIImage(systemName: "play.circle.fill")
        isStarted = false
        
        if !isTimer {
            pickerView.isHidden = false
            let timeComponents = secondsToHoursMinutesSeconds(seconds: Int(elapsedTimeInSeconds))
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
            elapsedTimeInSeconds = Double(hour) * 3600.0 + Double(min) * 60.0 + Double(sec)
        }
        pickerView.isHidden = true
    }
    
    
    //For Dynamic Sizes
    func heightD(_ num: Double) -> Double {
        return UIScreen.main.bounds.height * num / 896
    }
    
    func widthD(_ num: Double) -> Double{
        return UIScreen.main.bounds.width * num / 414
    }
}

