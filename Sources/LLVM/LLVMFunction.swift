import LLVMC

public final class LLVMFunction: LLVMConstant {
    
    @inlinable
    internal init(_rawValue: LLVMValueRef, in module: LLVMModule) {
        super.init(_rawValue: _rawValue, in: .module(module))
    }
    
    @inlinable
    public func argument(at index: Int) -> LLVMArgument {
        guard let rawIndex = UInt32(exactly: index) else {
            preconditionFailure("Expected an index between \(UInt32.min) and \(UInt32.max), but got \(index)")
        }
        return LLVMArgument(_rawValue: LLVMGetParam(_rawValue, rawIndex), in: _container)
    }
    
    @inlinable
    public func appendBasicBlock(_ name: String = "") -> LLVMBasicBlock {
        precondition(
            !name.contains("\0"),
            "Unexpected character '\0' in '\(name.debugDescription.dropFirst().dropLast())'"
        )
        return LLVMBasicBlock(_rawBlock: LLVMAppendBasicBlockInContext(_rawContext, _rawValue, name), in: _container)
    }
}
