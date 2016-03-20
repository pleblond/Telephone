//
//  UserAgentEventTargetCompositeTests.swift
//  Telephone
//
//  Copyright (c) 2008-2015 Alexey Kuznetsov
//
//  Telephone is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Telephone is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

import UseCases
import UseCasesTestDoubles
import XCTest

class UserAgentEventTargetCompositeTests: XCTestCase {
    private var sut: UserAgentEventTargetComposite!
    private var target1: UserAgentEventTargetSpy!
    private var target2: UserAgentEventTargetSpy!
    private var userAgentDummy: UserAgentSpy!

    override func setUp() {
        super.setUp()
        target1 = UserAgentEventTargetSpy()
        target2 = UserAgentEventTargetSpy()
        sut = UserAgentEventTargetComposite(targets: [target1, target2])
        userAgentDummy = UserAgentSpy()
    }

    func testCallsDidFinishStartingOnAllChildren() {
        sut.userAgentDidFinishStarting(userAgentDummy)

        XCTAssertTrue(target1.didCallUserAgentDidFinishStarting)
        XCTAssertTrue(target2.didCallUserAgentDidFinishStarting)
        assertUserAgent()
    }

    func testCallsDidFinishStoppingOnAllChildren() {
        sut.userAgentDidFinishStopping(userAgentDummy)

        XCTAssertTrue(target1.didCallUserAgentDidFinishStopping)
        XCTAssertTrue(target2.didCallUserAgentDidFinishStopping)
        assertUserAgent()
    }

    func testCallsDidDetectNATOnAllChildren() {
        sut.userAgentDidDetectNAT(userAgentDummy)

        XCTAssertTrue(target1.didCallUserAgentDidDetectNAT)
        XCTAssertTrue(target2.didCallUserAgentDidDetectNAT)
        assertUserAgent()
    }

    private func assertUserAgent() {
        XCTAssertTrue(target1.lastPassedUserAgent === userAgentDummy)
        XCTAssertTrue(target2.lastPassedUserAgent === userAgentDummy)
    }
}