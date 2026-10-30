import LLVMC

public final class LLVMFunction: LLVMValue {
    
    @inlinable
    public func appendBasicBlock(_ name: String = "") -> LLVMBasicBlock {
        LLVMBasicBlock(_rawBlock: LLVMAppendBasicBlockInContext(_rawContext, _rawValue, name), in: _container)
    }
}
