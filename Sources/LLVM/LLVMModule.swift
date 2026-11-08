import LLVMC

public final class LLVMModule {
    
    @usableFromInline
    internal let _rawModule: LLVMModuleRef
    
    public let context: LLVMContext
    
    @inlinable
    public init(id: String, sourceFileName: String, in context: LLVMContext) {
        precondition(!id.contains("\0"), "Unexpected character \"\\0\" in \(id.debugDescription)")
        self._rawModule = LLVMModuleCreateWithNameInContext(id, context._rawContext)
        self.context = context
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
    public func addFunction(_ name: String, type: LLVMFunctionType, linkage: LLVMLinkage = .external) -> LLVMFunction {
        precondition(!name.contains("\0"), "Unexpected character \"\\0\" in \(name.debugDescription)")
        precondition(type.context == context, "The type is not in the same context as the module")
        let rawValue = LLVMAddFunction(_rawModule, name, type._rawType) as LLVMValueRef
        if linkage != .external {
            LLVMSetLinkage(rawValue, linkage._rawLinkage)
        }
        return LLVMFunction(_rawValue: rawValue, in: self)
    }

    @inlinable
    public func addGlobal(_ name: String, type: LLVMType, linkage: LLVMLinkage = .external) -> LLVMGlobalVariable {
        precondition(!name.contains("\0"), "Unexpected character \"\\0\" in \(name.debugDescription)")
        precondition(type.context == context, "The type is not in the same context as the module")
        let rawValue = LLVMAddGlobal(_rawModule, type._rawType, name) as LLVMValueRef
        if linkage != .external {
            LLVMSetLinkage(rawValue, linkage._rawLinkage)
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
