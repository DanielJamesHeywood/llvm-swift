public struct LLVMError: Hashable, Error {
    
    public let message: String
    
    @inlinable
    internal init(_message: String) {
        self.message = _message
    }
}

extension LLVMError: CustomStringConvertible {
    
    @inlinable
    public var description: String { message }
}

extension LLVMError: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "LLVM.LLVMError(message: \(message.debugDescription))" }
}
