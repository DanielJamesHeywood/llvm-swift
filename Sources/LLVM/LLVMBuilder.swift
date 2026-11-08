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
        precondition(block.context == context, "The block is not in the same context as the builder")
        LLVMPositionBuilderAtEnd(_rawBuilder, block._rawBlock)
        _container = block._container
    }
    
    @inlinable
    public func buildReturn(
        of value: LLVMValue
    ) -> LLVMReturnInstruction {
        LLVMReturnInstruction(
            _rawValue: LLVMBuildRet(_rawBuilder, value._rawValue),
            in: _container.intersection(value._container)
        )
    }
    
    @inlinable
    public func buildCall(
        to callee: LLVMValue,
        ofType type: LLVMFunctionType,
        passing arguments: [LLVMValue],
        name: String = ""
    ) -> LLVMCallInstruction {
        precondition(type.context == context, "The type is not in the same context as the builder")
        precondition(!name.contains("\0"), "Unexpected character \"\\0\" in \(name.debugDescription)")
        var rawArguments = arguments.map { $0._rawValue as LLVMValueRef? }
        return LLVMCallInstruction(
            _rawValue: rawArguments.withUnsafeMutableBufferPointer { buffer in
                guard let argumentCount = UInt32(exactly: buffer.count) else {
                    preconditionFailure("Expected at most \(UInt32.max) arguments, but got \(buffer.count)")
                }
                return LLVMBuildCall2(
                    _rawBuilder,
                    type._rawType,
                    callee._rawValue,
                    buffer.baseAddress,
                    argumentCount,
                    name
                )
            },
            in: arguments.reduce(_container.intersection(callee._container)) { $0.intersection($1._container) }
        )
    }
    
    @inlinable
    public func buildExtraction(
        fromAggregate aggregate: LLVMValue,
        at index: Int,
        name: String = ""
    ) -> LLVMValue {
        precondition(!name.contains("\0"), "Unexpected character \"\\0\" in \(name.debugDescription)")
        guard let rawIndex = UInt32(exactly: index) else {
            preconditionFailure("Expected an index between \(UInt32.min) and \(UInt32.max), but got \(index)")
        }
        return LLVMValue(
            _rawValue: LLVMBuildExtractValue(_rawBuilder, aggregate._rawValue, rawIndex, name),
            in: _container.intersection(aggregate._container)
        )
    }
    
    @inlinable
    public func buildInsertion(
        of element: LLVMValue,
        intoAggregate aggregate: LLVMValue,
        at index: Int,
        name: String = ""
    ) -> LLVMValue {
        precondition(!name.contains("\0"), "Unexpected character \"\\0\" in \(name.debugDescription)")
        guard let rawIndex = UInt32(exactly: index) else {
            preconditionFailure("Expected an index between \(UInt32.min) and \(UInt32.max), but got \(index)")
        }
        return LLVMValue(
            _rawValue: LLVMBuildInsertValue(_rawBuilder, aggregate._rawValue, element._rawValue, rawIndex, name),
            in: _container.intersection(aggregate._container).intersection(element._container)
        )
    }
    
    @inlinable
    public func buildTruncation(
        of value: LLVMValue,
        to type: LLVMType,
        name: String = ""
    ) -> LLVMValue {
        precondition(type.context == context, "The type is not in the same context as the builder")
        precondition(!name.contains("\0"), "Unexpected character \"\\0\" in \(name.debugDescription)")
        return LLVMValue(
            _rawValue: LLVMBuildTrunc(_rawBuilder, value._rawValue, type._rawType, name),
            in: _container.intersection(value._container)
        )
    }
    
    @inlinable
    public func buildBitCast(
        of value: LLVMValue,
        to type: LLVMType,
        name: String = ""
    ) -> LLVMValue {
        precondition(type.context == context, "The type is not in the same context as the builder")
        precondition(!name.contains("\0"), "Unexpected character \"\\0\" in \(name.debugDescription)")
        return LLVMValue(
            _rawValue: LLVMBuildBitCast(_rawBuilder, value._rawValue, type._rawType, name),
            in: _container.intersection(value._container)
        )
    }
    
    @inlinable
    public func buildLoad(
        of type: LLVMType,
        fromPointer pointer: LLVMValue,
        name: String = ""
    ) -> LLVMLoadInstruction {
        precondition(type.context == context, "The type is not in the same context as the builder")
        precondition(!name.contains("\0"), "Unexpected character \"\\0\" in \(name.debugDescription)")
        return LLVMLoadInstruction(
            _rawValue: LLVMBuildLoad2(_rawBuilder, type._rawType, pointer._rawValue, name),
            in: _container.intersection(pointer._container)
        )
    }
    
    @inlinable
    public func buildStore(
        of value: LLVMValue,
        toPointer pointer: LLVMValue
    ) -> LLVMStoreInstruction {
        LLVMStoreInstruction(
            _rawValue: LLVMBuildStore(_rawBuilder, value._rawValue, pointer._rawValue),
            in: _container.intersection(value._container).intersection(pointer._container)
        )
    }
    
    @inlinable
    public var context: LLVMContext { _container.context }
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
    public var customMirror: Mirror { Mirror(self, children: [:], displayStyle: .class) }
}
