import Foundation

internal extension Pipe {
  func writeAndClose(_ string: String) {
    fileHandleForWriting.write(Data(string.utf8))
    fileHandleForWriting.closeFile()
  }
}
