//
//  SnowEmitter.swift
//  AnimationTests
//
//  Created by Рома Сорока on 12/25/18.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation
import QuartzCore.CoreAnimation
import UIKit.UIImage

class SnowEmitter {
    static func snowLayer(position: CGPoint, size: CGSize) -> CAEmitterLayer {
        let flakeEmitterCell = CAEmitterCell()
        flakeEmitterCell.contents = UIImage(named: "snowflake")?.cgImage
        flakeEmitterCell.scale = 0.06
        flakeEmitterCell.scaleRange = 0.3
        flakeEmitterCell.emissionRange = .pi
        flakeEmitterCell.lifetime = 20.0
        flakeEmitterCell.birthRate = 80
        flakeEmitterCell.velocity = -30
        flakeEmitterCell.velocityRange = -20
        flakeEmitterCell.yAcceleration = 30
        flakeEmitterCell.xAcceleration = 5
        flakeEmitterCell.spin = -0.5
        flakeEmitterCell.spinRange = 1.0

        let snowEmitterLayer = CAEmitterLayer()
        snowEmitterLayer.emitterPosition = position
        snowEmitterLayer.emitterSize = size
        snowEmitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        snowEmitterLayer.beginTime = CACurrentMediaTime()
        snowEmitterLayer.timeOffset = 10
        snowEmitterLayer.emitterCells = [flakeEmitterCell]
        
        return snowEmitterLayer
    }
}
