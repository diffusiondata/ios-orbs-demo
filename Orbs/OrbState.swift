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

class OrbState {
    let location: (x: Float, y: Float)
    let colour: (r: Float, g: Float, b: Float, a: Float)

    init(csv: String) {
        let fields = csv.components(separatedBy: ",")
        let xField = fields[0]
        let yField = fields[1]
        let colourField = fields[2]
        let alphaField = fields[3]

        location = (Float(xField)!, Float(yField)!)

        // Colour field is three characters, each being a hexadecimal digit
        // representing the most significant nibble for a colour component.
        var cc = colourField.startIndex;
        let r = Int(colourField.substring(with: cc...cc), radix: 16)
        cc = <#T##Collection corresponding to `cc`##Collection#>.index(cc, offsetBy: 1)
        let g = Int(colourField.substring(with: cc...cc), radix: 16)
        cc = <#T##Collection corresponding to `cc`##Collection#>.index(cc, offsetBy: 1)
        let b = Int(colourField.substring(with: cc...cc), radix: 16)

        // Store colour components, including opacity, as RGBA tuple.
        colour = (
            Float(r!) / 15.0,
            Float(g!) / 15.0,
            Float(b!) / 15.0,
            Float(alphaField)!)
    }
}
