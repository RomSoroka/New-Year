//
//  ViewController.swift
//  AnimationTests
//
//  Created by Рома Сорока on 12/24/18.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var clouds: [UIImageView]!
    @IBOutlet weak var sun: UIImageView!
    @IBOutlet weak var snowman: UIImageView!
    
    @IBOutlet weak var bounceButton: UIButton!
    
    private func rotateView(_ targetView: UIView, halfTurnSpeed: Double = 1.0) {
        UIView.animate(withDuration: halfTurnSpeed,
                       delay: 0.0,
                       options: .curveLinear,
                       animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat.pi)
                    }, completion: { finished in
            self.rotateView(targetView, halfTurnSpeed: halfTurnSpeed)
        })
    }
    private func repeatedLinearMovement(_ targetView: UIView, toX x: CGFloat,
                                        duration: Double) {
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: [.repeat, .curveLinear],
                       animations: {
                        targetView.center.x = x
        }, completion: nil)
    }
    private func jump(_ targetView: UIView, by y: CGFloat, duration: Double) {
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: [.autoreverse, .repeat, .curveEaseOut],
                       animations: {
                        targetView.center.y -= y
        }, completion: nil )
        
    }
    
    @objc private func startRepeatAnimations() {
        clouds[0].center.x = -50.0
        clouds[1].center.x = -100.0
        clouds[2].center.x = -70.0
        clouds[3].center.x = -150.0
        repeatedLinearMovement(clouds[0], toX: 550, duration: 6.5)
        repeatedLinearMovement(clouds[1], toX: 600, duration: 7.5)
        repeatedLinearMovement(clouds[2], toX: 500, duration: 8.0)
        repeatedLinearMovement(clouds[3], toX: 650, duration: 13.0)
        snowman.frame.origin.y = view.frame.size.height - snowman.frame.height - 20
        jump(snowman, by: 150.0, duration: 0.5)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(startRepeatAnimations),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: UIApplication.shared)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startRepeatAnimations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateView(sun, halfTurnSpeed: 3.0)
        
        let pos = CGPoint(x: view.bounds.width / 2.0, y: -50)
        let size = CGSize(width: view.bounds.width, height: 0)
        let snowLayer = SnowEmitter.snowLayer(position: pos, size: size)
        view.layer.addSublayer(snowLayer)
        
    }
        
    @IBAction func bounceTouched(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
        }, completion: {(fin) in
            UIView.animate(withDuration: 1.5,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.35), //higher values finish faster
                initialSpringVelocity: CGFloat(6.0), //higher values more initial momentum
                options: .allowUserInteraction,
                animations: {
                    sender.transform = CGAffineTransform.identity
            },
                completion: nil)
            
        } )
        
        
    }
    

}
