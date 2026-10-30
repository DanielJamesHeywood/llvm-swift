import LLVMC

public final class LLVMModule {
    
    @usableFromInline
    internal let _rawModule: LLVMModuleRef
    
    @usableFromInline
    internal let _context: LLVMContext
    
    @inlinable
    public init(id: String, sourceFileName: String, in context: LLVMContext) {
        self._rawModule = LLVMModuleCreateWithNameInContext(id, context._rawContext)
        self._context = context
        var sourceFileName = sourceFileName
        sourceFileName.withUTF8 { buffer in
            LLVMSetSourceFileName(_rawModule, buffer.baseAddress, buffer.count)
        }
    }
    
    @inlinable
    deinit {
        LLVMDisposeModule(_rawModule)
    }
    
    @inlinable
    public func addFunction(
        _ name: String,
        returnType: LLVMType,
        parameterTypes: some Sequence<LLVMType>,
        isVariableArgument: Bool = false
    ) -> LLVMFunction {
        precondition(
            returnType._context == _context,
            "The return type is not in the same context as the module"
        )
        precondition(
            parameterTypes.allSatisfy { $0._context == _context },
            "The parameter types are not all in the same context as the module"
        )
        var rawParameterTypes = parameterTypes.map { $0._rawType as LLVMTypeRef? }
        return LLVMFunction(
            _rawValue: LLVMAddFunction(
                _rawModule,
                name,
                rawParameterTypes.withUnsafeMutableBufferPointer { buffer in
                    guard let parameterCount = UInt32(exactly: buffer.count) else {
                        preconditionFailure("Expected at most \(UInt32.max) parameters, but got \(buffer.count)")
                    }
                    return LLVMFunctionType(
                        returnType._rawType,
                        buffer.baseAddress,
                        parameterCount,
                        isVariableArgument ? 1 : 0
                    )
                }
            ),
            in: self
        )
    }
    
    @inlinable
    internal var _rawContext: LLVMContextRef { _context._rawContext }
}

extension LLVMModule: Equatable {
    
    @inlinable
    public static func == (lhs: LLVMModule, rhs: LLVMModule) -> Bool { lhs._rawModule == rhs._rawModule }
}

extension LLVMModule: Hashable {
    
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_rawModule)
    }
}

extension LLVMModule: CustomReflectable {
    
    @inlinable
    public var customMirror: Mirror { Mirror(self, children: [:]) }
}
