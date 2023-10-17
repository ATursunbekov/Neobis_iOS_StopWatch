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
        
        NSLayoutConstraint.activate([
            timerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: heightD(20)),
            timerImage.widthAnchor.constraint(equalToConstant: heightD(100)),
            timerImage.heightAnchor.constraint(equalToConstant: heightD(100)),
            
            segmentController.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentController.topAnchor.constraint(equalTo: timerImage.bottomAnchor, constant: heightD(20))
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

