import LLVMC

public final class LLVMFunction: LLVMValue {
    
    @inlinable
    public func argument(at index: Int) -> LLVMArgument {
        guard let rawIndex = UInt32(exactly: index) else {
            preconditionFailure("Expected an index between \(UInt32.min) and \(UInt32.max), but got \(index)")
        }
        return LLVMArgument(_rawValue: LLVMGetParam(_rawValue, rawIndex), in: _container)
    }
    
    @inlinable
    public func appendBasicBlock(_ name: String = "") -> LLVMBasicBlock {
        LLVMBasicBlock(_rawBlock: LLVMAppendBasicBlockInContext(_rawContext, _rawValue, name), in: _container)
    }
}
