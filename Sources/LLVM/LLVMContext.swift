import LLVMC

public final class LLVMContext {
    
    @usableFromInline
    internal let _rawContext = LLVMContextCreate() as LLVMContextRef
    
    @inlinable
    public init() {}
    
    @inlinable
    deinit {
        LLVMContextDispose(_rawContext)
    }
}

extension LLVMContext: Equatable {
    
    @inlinable
    public static func == (lhs: LLVMContext, rhs: LLVMContext) -> Bool { lhs._rawContext == rhs._rawContext }
}

extension LLVMContext: Hashable {
    
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_rawContext)
    }
}

extension LLVMContext: CustomReflectable {
    
    @inlinable
    public var customMirror: Mirror { Mirror(self, children: [:], displayStyle: .class) }
}
