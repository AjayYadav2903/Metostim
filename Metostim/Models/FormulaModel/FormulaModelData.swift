/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct FormulaModelData : Codable {
	let birds_Code : Int?
	let birds_Name : String?
	let days : Int?
	let formulaValue : Double?
	let birdValue : Int?
	let climate_Name : String?
	let climate_code : Int?

	enum CodingKeys: String, CodingKey {

		case birds_Code = "Birds_Code"
		case birds_Name = "Birds_Name"
		case days = "Days"
		case formulaValue = "FormulaValue"
		case birdValue = "BirdValue"
		case climate_Name = "Climate_Name"
		case climate_code = "Climate_code"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		birds_Code = try values.decodeIfPresent(Int.self, forKey: .birds_Code)
		birds_Name = try values.decodeIfPresent(String.self, forKey: .birds_Name)
		days = try values.decodeIfPresent(Int.self, forKey: .days)
		formulaValue = try values.decodeIfPresent(Double.self, forKey: .formulaValue)
		birdValue = try values.decodeIfPresent(Int.self, forKey: .birdValue)
		climate_Name = try values.decodeIfPresent(String.self, forKey: .climate_Name)
		climate_code = try values.decodeIfPresent(Int.self, forKey: .climate_code)
	}

}
