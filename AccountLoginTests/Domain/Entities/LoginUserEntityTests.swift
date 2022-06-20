//
//  LoginUserEntityTests.swift
//  AccountLoginTests
//
//  Created by Jill Chang on 2022/6/19.
//

import XCTest
import AccountLogin

class LoginUserEntityTests: XCTestCase {
    func test_jsonStirng_decodeEntity() {
        let json = """
            {
                "objectId": "WkuKfCAdGq",
                "username": "test2@qq.com",
                "code": "4wtmah5h",
                "isVerifiedReportEmail": true,
                "reportEmail": "test2@qq.com",
                "createdAt": "2019-07-12T07:07:18.027Z",
                "updatedAt": "2022-06-02T09:33:29.870Z",
                "timezone": 20,
                "parameter": 8,
                "number": 5,
                "phone": "123",
                "timeZone": "Asia/Taipei",
                "timone": "10",
                "ACL": {
                    "WkuKfCAdGq": {
                        "read": true,
                        "write": true
                    }
                },
                "sessionToken": "r:685e5750ea96957fd7f41186c4c69a74"
            }
            """
        
        guard let jsonData = json.data(using: .utf8) else {
            XCTFail("string converted JSON Error.")
            return
        }
        
        guard let dto: LoginUserDTO = try? JSONDecoder().decode(LoginUserDTO.self, from: jsonData) else {
            XCTFail("data decode DTO Error.")
            return
        }
        
        let entity = dto.toDomain()
        
        XCTAssertEqual(entity.objectID, "WkuKfCAdGq")
        XCTAssertEqual(entity.username, "test2@qq.com")
        XCTAssertEqual(entity.code, "4wtmah5h")
        XCTAssertEqual(entity.timezone, 20)
        XCTAssertEqual(entity.parameter, 8)
        XCTAssertEqual(entity.number, 5)
        XCTAssertEqual(entity.phone, "123")
        XCTAssertEqual(entity.timeZone, "Asia/Taipei")
        XCTAssertEqual(entity.timone, "10")
        XCTAssertEqual(entity.sessionToken, "r:685e5750ea96957fd7f41186c4c69a74")
    }
}

