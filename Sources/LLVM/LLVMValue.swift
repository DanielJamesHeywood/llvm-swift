import LLVMC

public class LLVMValue {
    
    @usableFromInline
    internal let _rawValue: LLVMValueRef
    
    @usableFromInline
    internal let _container: _Container
    
    @inlinable
    internal init(_rawValue: LLVMValueRef, in container: _Container) {
        self._rawValue = _rawValue
        self._container = container
    }
    
    @inlinable
    internal convenience init(_rawValue: LLVMValueRef, in context: LLVMContext) {
        self.init(_rawValue: _rawValue, in: .context(context))
    }
    
    @inlinable
    internal convenience init(_rawValue: LLVMValueRef, in module: LLVMModule) {
        self.init(_rawValue: _rawValue, in: .module(module))
    }
    
    @inlinable
    internal final var _context: LLVMContext { _container.context }
    
    @inlinable
    internal final var _rawContext: LLVMContextRef { _context._rawContext }
}

extension LLVMValue: Equatable {
    
    @inlinable
    public static func == (lhs: LLVMValue, rhs: LLVMValue) -> Bool { lhs._rawValue == rhs._rawValue }
}

extension LLVMValue: Hashable {
    
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_rawValue)
    }
}

extension LLVMValue: CustomReflectable {
    
    @inlinable
    public var customMirror: Mirror { Mirror(self, children: [:]) }
}
