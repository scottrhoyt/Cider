import XCTest
@testable import CiderTests

XCTMain([
    testCase(AlbumTests.allTests),
    testCase(ArtistTests.allTests),
    testCase(ArtworkTests.allTests),
    testCase(CiderUrlBuilderTests.allTests),
    testCase(TrackTests.allTests),
])
