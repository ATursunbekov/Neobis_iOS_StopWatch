//
//  ViewController.swift
//  Neobis_iOS_StopWatch
//
//  Created by Alikhan Tursunbekov on 17/10/23.
//

import UIKit

class ViewController: UIViewController {
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
        let image = UIImageView()
        image.image = UIImage(systemName: "stop.circle.fill")
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
        setupConstraints()
        setupTargets()
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
        ])
    }
    
    func setupTargets() {
        segmentController.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        if selectedIndex == 0 {
            timerImage.image = UIImage(systemName: "timer")
        } else {
            timerImage.image = UIImage(systemName: "stopwatch")
        }
    }
    
    func heightD(_ num: Double) -> Double {
        return UIScreen.main.bounds.height * num / 896
    }
    
    func widthD(_ num: Double) -> Double{
        return UIScreen.main.bounds.width * num / 414
    }
}

