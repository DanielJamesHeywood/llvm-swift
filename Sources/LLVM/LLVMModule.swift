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
    public func addGlobal(
        _ name: String = "",
        type: LLVMType,
        linkage: LLVMLinkage = .external,
        initialValue: LLVMConstant? = nil
    ) -> LLVMGlobalVariable {
        precondition(type._context == _context, "The type is not in the same context as the module")
        let rawValue = LLVMAddGlobal(_rawModule, type._rawType, name) as LLVMValueRef
        if linkage != .external {
            LLVMSetLinkage(rawValue, linkage._rawLinkage)
        }
        if let initialValue {
            switch initialValue._container {
            case let .context(context):
                precondition(_context == context, "The initial value is not in the same context as the module")
            case let .module(module):
                precondition(self == module, "The initial value is in another module")
            }
            LLVMSetInitializer(rawValue, initialValue._rawValue)
        }
        return LLVMGlobalVariable(_rawValue: rawValue, in: self)
    }
    
    @inlinable
    public func printToString() -> String {
        let rawMessage = LLVMPrintModuleToString(_rawModule) as UnsafeMutablePointer<CChar>
        defer {
            LLVMDisposeMessage(rawMessage)
        }
        return String(cString: rawMessage)
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
