//
//  ImageAnimationHelper.swift
//  StarWars
//
//  Created by Juan Enriquez on 8/22/18.
//  Copyright © 2018 JuanEnriquez. All rights reserved.
//

import Foundation
import UIKit

let animationImages = [UIImage(named: "tieLoader1"),UIImage(named: "tieLoader2"),UIImage(named: "tieLoader3"),UIImage(named: "tieLoader4"),UIImage(named: "tieLoader5"),UIImage(named: "tieLoader6"),UIImage(named: "tieLoader7"),UIImage(named: "tieLoader8"),UIImage(named: "tieLoader9"),UIImage(named: "tieLoader10"),UIImage(named: "tieLoader11"),UIImage(named: "tieLoader12"),UIImage(named: "tieLoader13"),UIImage(named: "tieLoader14"),UIImage(named: "tieLoader15"),UIImage(named: "tieLoader16"),UIImage(named: "tieLoader17"),UIImage(named: "tieLoader18"),UIImage(named: "tieLoader19"),UIImage(named: "tieLoader20"),UIImage(named: "tieLoader21"),UIImage(named: "tieLoader22"),UIImage(named: "tieLoader23"),UIImage(named: "tieLoader24"),UIImage(named: "tieLoader25"),UIImage(named: "tieLoader26"),UIImage(named: "tieLoader27"),UIImage(named: "tieLoader28"),UIImage(named: "tieLoader29"),UIImage(named: "tieLoader30"),UIImage(named: "tieLoader31")] as! [UIImage]
let animationImages2 = [UIImage(named: "frame-0"),UIImage(named: "frame-1"),UIImage(named: "frame-2"),UIImage(named: "frame-3"),UIImage(named: "frame-4"),UIImage(named: "frame-5"),UIImage(named: "frame-6"),UIImage(named: "frame-7"),UIImage(named: "frame-8"),UIImage(named: "frame-9"),UIImage(named: "frame-10"),UIImage(named: "frame-11"),UIImage(named: "frame-12"),UIImage(named: "frame-13"),UIImage(named: "frame-14"),UIImage(named: "frame-15"),UIImage(named: "frame-16"),UIImage(named: "frame-17"),UIImage(named: "frame-18"),UIImage(named: "frame-19"),UIImage(named: "frame-20"),UIImage(named: "frame-21"),UIImage(named: "frame-22"),UIImage(named: "frame-23"),UIImage(named: "frame-24"),UIImage(named: "frame-25"),UIImage(named: "frame-26"),UIImage(named: "frame-27"),UIImage(named: "frame-28"),UIImage(named: "frame-29")] as! [UIImage]

func setupImageAnimation()-> UIImage{
    return UIImage.animatedImage(with: animationImages2, duration: 1.7)!
}
