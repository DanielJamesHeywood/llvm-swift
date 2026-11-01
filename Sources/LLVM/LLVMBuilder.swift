import LLVMC

public final class LLVMBuilder {
    
    @usableFromInline
    internal let _rawBuilder: LLVMBuilderRef
    
    @usableFromInline
    internal var _container: _Container
    
    @inlinable
    public init(in context: LLVMContext) {
        self._rawBuilder = LLVMCreateBuilderInContext(context._rawContext)
        self._container = .context(context)
    }
    
    @inlinable
    deinit {
        LLVMDisposeBuilder(_rawBuilder)
    }
    
    @inlinable
    public func position(atEndOf block: LLVMBasicBlock) {
        precondition(_context == block._context, "The block is not in the same context as the builder")
        LLVMPositionBuilderAtEnd(_rawBuilder, block._rawBlock)
        _container = block._container
    }
    
    @inlinable
    public func buildReturn(of value: LLVMValue) -> LLVMReturnInstruction {
        LLVMReturnInstruction(
            _rawValue: LLVMBuildRet(_rawBuilder, value._rawValue),
            in: _container.intersection(value._container)
        )
    }
    
    @inlinable
    public func buildTruncation(of value: LLVMValue, to type: LLVMType, name: String = "") -> LLVMValue {
        precondition(type._context == _context, "The type is not in the same context as the builder")
        return LLVMValue(
            _rawValue: LLVMBuildTrunc(_rawBuilder, value._rawValue, type._rawType, name),
            in: _container.intersection(value._container)
        )
    }
    
    @inlinable
    public func buildBitCast(of value: LLVMValue, to type: LLVMType, name: String = "") -> LLVMValue {
        precondition(type._context == _context, "The type is not in the same context as the builder")
        return LLVMValue(
            _rawValue: LLVMBuildBitCast(_rawBuilder, value._rawValue, type._rawType, name),
            in: _container.intersection(value._container)
        )
    }
    
    @inlinable
    internal var _context: LLVMContext { _container.context }
}

extension LLVMBuilder: Equatable {
    
    @inlinable
    public static func == (lhs: LLVMBuilder, rhs: LLVMBuilder) -> Bool { lhs._rawBuilder == rhs._rawBuilder }
}

extension LLVMBuilder: Hashable {
    
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_rawBuilder)
    }
}

extension LLVMBuilder: CustomReflectable {
    
    @inlinable
    public var customMirror: Mirror { Mirror(self, children: [:]) }
}
