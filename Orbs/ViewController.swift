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

    var observers = [NSObjectProtocol]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create Diffusion client subscribing for updates to Orbs
        let client = OrbsClient()
        let layer = orbsView?.layer as? OrbsLayer
        client.listener = layer

        // Connect immediately
        let url:URL = URL(string: "ws://localhost:8080")!;
        client.connect(url: url)

        // Observe application foreground state, as we don't want our connection
        // to the Diffusion server active when in the background.
        let nc = NotificationCenter.default
        observers.append(nc.addObserver(forName: NSNotification.Name.UIApplicationDidEnterBackground, object: nil, queue: nil) { (NSNotification) in
            client.disconnect()
        })
        observers.append(nc.addObserver(forName: NSNotification.Name.UIApplicationWillEnterForeground, object: nil, queue: nil) { (NSNotification) in
            client.connect(url: url)
        })

        // Maintain strong reference to the Orbs client for the lifespan of
        // this view controller instance.
        self.client = client
    }

    deinit {
        let nc = NotificationCenter.default
        for observer in observers {
            nc.removeObserver(observer)
        }
    }
}
