/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct BirdTypeDataModel : Codable {
	let iD : Int?
	let birds_Code : Int?
	let birds_Name : String?
	let climate_code : Int?
	let climate_name : String?
	let birds_Image : String?

	enum CodingKeys: String, CodingKey {

		case iD = "ID"
		case birds_Code = "Birds_Code"
		case birds_Name = "Birds_Name"
		case climate_code = "Climate_code"
		case climate_name = "Climate_name"
		case birds_Image = "Birds_Image"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		iD = try values.decodeIfPresent(Int.self, forKey: .iD)
		birds_Code = try values.decodeIfPresent(Int.self, forKey: .birds_Code)
		birds_Name = try values.decodeIfPresent(String.self, forKey: .birds_Name)
		climate_code = try values.decodeIfPresent(Int.self, forKey: .climate_code)
		climate_name = try values.decodeIfPresent(String.self, forKey: .climate_name)
		birds_Image = try values.decodeIfPresent(String.self, forKey: .birds_Image)
	}

}
