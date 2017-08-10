import XCTest
@testable import TestCiderSPMTests

XCTMain([
    testCase(AlbumTests.allTests),
    testCase(ArtistTests.allTests),
    testCase(ArtworkTests.allTests),
    testCase(CiderUrlBuilderTests.allTests),
    testCase(TrackTests.allTests),
])
