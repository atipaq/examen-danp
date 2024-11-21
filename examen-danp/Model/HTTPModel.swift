//
//  HTTPModel.swift
//  examen-danp
//
//  Created by atipaq on 21/11/24.
//

import Foundation

struct WorkResponse: Decodable {
    let success: Bool
    let data: [Food]
    let count: Int
    let offset: Int
    let limit: Int
}
