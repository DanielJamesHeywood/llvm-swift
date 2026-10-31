import LLVMC

@inlinable
public var llvmDefaultTargetTriple: String {
    let rawMessage = LLVMGetDefaultTargetTriple()
    defer {
        LLVMDisposeMessage(rawMessage.unsafelyUnwrapped)
    }
    return String(cString: rawMessage.unsafelyUnwrapped)
}

@inlinable
public func llvmInitializeTargetInfos() {
    LLVMInitializeAllTargetInfos()
}
