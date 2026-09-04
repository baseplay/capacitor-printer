import XCTest
@testable import PrinterPlugin

class PrinterTests: XCTestCase {
    func testResolveJobNameFallsBackToDefault() {
        let implementation = Printer()

        XCTAssertEqual(implementation.resolveJobName(nil), Printer.defaultJobName)
        XCTAssertEqual(implementation.resolveJobName(""), Printer.defaultJobName)
        XCTAssertEqual(implementation.resolveJobName("   \n"), Printer.defaultJobName)
    }

    func testResolveJobNameTrimsWhitespace() {
        XCTAssertEqual(Printer().resolveJobName("  Leg Day  "), "Leg Day")
    }
}
