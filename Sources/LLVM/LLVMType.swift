import LLVMC

public class LLVMType {
    
    @usableFromInline
    internal let _rawType: LLVMTypeRef
    
    @usableFromInline
    internal let _context: LLVMContext
    
    @inlinable
    internal init(_rawType: LLVMTypeRef, in context: LLVMContext) {
        self._rawType = _rawType
        self._context = context
    }
}

extension LLVMType: Equatable {
    
    @inlinable
    public static func == (lhs: LLVMType, rhs: LLVMType) -> Bool { lhs._rawType == rhs._rawType }
}

extension LLVMType: Hashable {
    
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_rawType)
    }
}

extension LLVMType: CustomReflectable {
    
    @inlinable
    public var customMirror: Mirror { Mirror(self, children: [:]) }
}
