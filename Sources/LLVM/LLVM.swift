import LLVMC

@inlinable
public var llvmDefaultTargetTriple: String {
    let rawMessage = LLVMGetDefaultTargetTriple() as UnsafeMutablePointer<CChar>
    defer {
        LLVMDisposeMessage(rawMessage)
    }
    return String(cString: rawMessage)
}

@inlinable
public func llvmInitializeTargetInfos() {
    LLVMInitializeAllTargetInfos()
}

@inlinable
public func llvmInitializeTargets() {
    LLVMInitializeAllTargets()
}

@inlinable
public func llvmInitializeTargetMachineCodes() {
    LLVMInitializeAllTargetMCs()
}
