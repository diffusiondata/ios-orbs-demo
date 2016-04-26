//  Native Orbs Demo for iOS
//
//  Copyright (C) 2016 Push Technology Ltd.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import UIKit

class OrbsLayer: CALayer, OrbListener {
    var layers = [OrbKey: OrbLayer]()

    func orbDidUpdate(key: OrbKey, state: OrbState) {
        if let existingLayer = layers[key] {
            existingLayer.state = state
        } else {
            let newLayer = OrbLayer()
            newLayer.state = state
            layers[key] = newLayer
            addSublayer(newLayer)
        }
    }

    func orbDidDisappear(key: OrbKey) {
        if let layer = layers[key] {
            layer.removeFromSuperlayer()
            layers[key] = nil
        }
    }

    override func layoutSublayers() {
        let size = min(self.bounds.width, self.bounds.height)
        let bounds = CGRect(origin: self.bounds.origin, size: CGSize(width: size, height: size))
        for layer in layers.values {
            layer.performanceBounds = bounds
        }
    }
}
