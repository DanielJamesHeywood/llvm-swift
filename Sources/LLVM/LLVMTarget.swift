import LLVMC

public struct LLVMTarget: Hashable {
    
    @usableFromInline
    internal let _rawTarget: LLVMTargetRef
    
    @inlinable
    public init(triple: String) throws(LLVMError) {
        var rawTarget = nil as LLVMTargetRef?
        var rawMessage = nil as UnsafeMutablePointer<CChar>?
        guard LLVMGetTargetFromTriple(triple, &rawTarget, &rawMessage) == 0 else {
            defer {
                LLVMDisposeMessage(rawMessage.unsafelyUnwrapped)
            }
            throw LLVMError(_message: String(cString: rawMessage.unsafelyUnwrapped))
        }
        self._rawTarget = rawTarget.unsafelyUnwrapped
    }
}

extension LLVMTarget: CustomReflectable {
    
    @inlinable
    public var customMirror: Mirror { Mirror(self, children: [:]) }
}
