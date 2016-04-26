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

class ViewController: UIViewController {
    private var client: OrbsClient?

    @IBOutlet weak var orbsView: OrbsView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create Diffusion client subscribing for updates to Orbs
        client = OrbsClient()
        let layer = orbsView?.layer as? OrbsLayer
        client!.listener = layer

        // Connect immediately
        let url:NSURL = NSURL(string: "ws://localhost:8080")!;
        client!.connect(url)
    }
}
