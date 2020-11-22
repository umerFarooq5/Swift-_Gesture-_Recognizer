//
//  ViewController.swift
//  Core_Animations
//
//  Created by umer malik on 20/11/2020.
//

import UIKit

class ViewController: UIViewController {
   
    var gradientLayer: CAGradientLayer!
    var gradientLayer2: CAGradientLayer!
    
    let circleView : UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    
    let trashView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "trash")
        view.clipsToBounds = true
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(panedView:)))
        circleView.addGestureRecognizer(pan)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        createCircleGradientLayer()
    }
    
   
    
    @objc func handlePan(panedView: UIPanGestureRecognizer) {
        if panedView.state == .began || panedView.state == .changed {
            
            let translation = panedView.translation(in: self.view)
            circleView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
            
        }
        else if panedView.state == .ended {
            ifPanEnded(panedView: circleView)
        }
    }
    
    
    
    func ifPanEnded(panedView: UIView) {
        
        if panedView.frame.intersects(trashView.frame) {
            UIView.animate(withDuration: 0.3) {
                self.circleView.alpha = 0.0
            }
        } else {
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseIn) {
                panedView.transform =  .identity
            }
        }
    }
    
    
    func createViews() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor,UIColor.green.cgColor]
        gradientLayer.locations = [0.4,0.6, 0.4]
        self.view.layer.addSublayer(gradientLayer)
        
        view.addSubview(circleView)
        circleView.layer.cornerRadius = 50
        circleView.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 5,  paddingRight: 5, width: 100, height: 100)
        
        view.addSubview(trashView)
        trashView.anchor(bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: 5, paddingRight: 5, width: 100, height: 100)
        view.bringSubviewToFront(circleView)
    }
    
    
    func createCircleGradientLayer() {
        gradientLayer2 = CAGradientLayer()
        gradientLayer2.frame = self.circleView.bounds
        gradientLayer2.colors   = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        self.circleView.layer.addSublayer(gradientLayer2)
    }
    
    
    
    
}

