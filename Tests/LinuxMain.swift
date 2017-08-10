import XCTest
@testable import AlbumTests
@testable import ArtistTests
@testable import ArtworkTests
@testable import CiderUrlBuilderTests
@testable import TrackTests

XCTMain([
    testCase(AlbumTests.allTests),
    testCase(ArtistTests.allTests),
    testCase(ArtworkTests.allTests),
    testCase(CiderUrlBuilderTests.allTests),
    testCase(TrackTests.allTests),
])
