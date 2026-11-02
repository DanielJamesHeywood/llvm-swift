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
        _ name: String = "",
        type: LLVMFunctionType,
        linkage: LLVMLinkage = .external
    ) -> LLVMFunction {
        precondition(type._context == _context, "The type is not in the same context as the module")
        let rawValue = LLVMAddFunction(_rawModule, name, type._rawType) as LLVMValueRef
        if linkage != .external {
            LLVMSetLinkage(rawValue, linkage._rawLinkage)
        }
        return LLVMFunction(_rawValue: rawValue, in: self)
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
