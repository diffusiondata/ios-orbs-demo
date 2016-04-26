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

import Foundation

class OrbKey: Hashable {
    let sessionId: String
    let orbIndex: UInt

    struct Static {
        static let regexPattern = "(.+)/orbs/(\\d+)";
        static let regex = try! NSRegularExpression(pattern: regexPattern, options: [])
    }

    init?(topicPath: String) {
        let string = topicPath as NSString
        let results = Static.regex.matchesInString(
            topicPath,
            options:[],
            range:NSMakeRange(0, string.length))
        if (1 != results.count) {
            return nil
        }
        let result = results[0]
        self.sessionId = string.substringWithRange(result.rangeAtIndex(1))
        self.orbIndex = UInt(string.substringWithRange(result.rangeAtIndex(2)))!
    }

    var hashValue: Int {
        return sessionId.hashValue ^ orbIndex.hashValue
    }

}

func ==(lhs: OrbKey, rhs: OrbKey) -> Bool {
    return lhs.sessionId == rhs.sessionId && lhs.orbIndex == rhs.orbIndex
}
