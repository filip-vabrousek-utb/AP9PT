import Foundation

enum Config {
    /// Launch with `-UseMockData` to run without network access.
    static var useMockData: Bool {
        ProcessInfo.processInfo.arguments.contains("-UseMockData")
    }
}
