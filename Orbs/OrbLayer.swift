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
import CoreGraphics

class OrbLayer: CALayer {
    private var _state: OrbState?
    private var _performanceBounds: CGRect?

    var state: OrbState? {
        get {
            return _state
        }

        set {
            _state = newValue

            if let state = newValue {
                // Colour can be set immediately as it's not dependant on
                // the performance bounds.
                let colour = state.colour;
                backgroundColor = UIColor(
                    colorLiteralRed: colour.r,
                    green: colour.g,
                    blue: colour.b,
                    alpha: colour.a).cgColor

                // The frame can only be set if we also know the performance bounds.
                updateFrame()
            }
        }
    }

    var performanceBounds: CGRect? {
        get {
            return _performanceBounds
        }

        set {
            _performanceBounds = newValue

            // The frame can only be set if we also have a current state and
            // performance bounds.
            updateFrame()
        }
    }

    private func updateFrame() {
        if let state = _state, let performanceBounds = _performanceBounds {
            let w = performanceBounds.size.width
            let r = w * 0.05
            let d = r * 2.0
            let size = CGSize(width: d, height: d)
            let x = CGFloat(state.location.x) * w - r
            let y = CGFloat(state.location.y) * w - r

            // Disable implicit basic animation duration (we don't want delay).
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.0)

            // Modify size-related properties now that we're within a no-delay
            // transaction.
            frame = CGRect(origin: CGPoint(x: x, y: y), size: size)
            cornerRadius = r

            CATransaction.commit()
        }
    }
}
