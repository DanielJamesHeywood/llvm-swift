import LLVMC

@inlinable
public var llvmDefaultTargetTriple: String {
    let rawMessage = LLVMGetDefaultTargetTriple()
    defer {
        LLVMDisposeMessage(rawMessage)
    }
    return String(cString: rawMessage!)
}
