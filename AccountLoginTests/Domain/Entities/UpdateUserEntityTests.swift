//
//  UpdateUserEntityTests.swift
//  AccountLoginTests
//
//  Created by Jill Chang on 2022/6/22.
//

import XCTest
import AccountLogin

class UpdateUserEntityTests: XCTestCase {
    func test_jsonStirng_decodeEntity() {
        let json = """
            {
                "updatedAt": "2022-06-17T08:29:29.513Z",
                "role": {
                    "__op": "Delete"
                }
            }
            """
        
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("string converted JSON Error.")
            return
        }
        
        guard let dto: UpdateUserDTO = try? JSONDecoder().decode(UpdateUserDTO.self, from: jsonData) else {
            XCTFail("data decode DTO Error.")
            return
        }
        
        let entity = dto.toDomain()
        
        XCTAssertEqual(entity.updatedAt, "2022-06-17T08:29:29.513Z")
    }
}

