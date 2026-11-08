import LLVMC

public final class LLVMBasicBlock {
    
    @usableFromInline
    internal let _rawBlock: LLVMBasicBlockRef
    
    @usableFromInline
    internal let _container: _Container
    
    @inlinable
    internal init(_rawBlock: LLVMBasicBlockRef, in container: _Container) {
        self._rawBlock = _rawBlock
        self._container = container
    }
    
    @inlinable
    public var context: LLVMContext { _container.context }
}

extension LLVMBasicBlock: Equatable {
    
    @inlinable
    public static func == (lhs: LLVMBasicBlock, rhs: LLVMBasicBlock) -> Bool { lhs._rawBlock == rhs._rawBlock }
}

extension LLVMBasicBlock: Hashable {
    
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_rawBlock)
    }
}

extension LLVMBasicBlock: CustomReflectable {
    
    @inlinable
    public var customMirror: Mirror { Mirror(self, children: [:]) }
}
