import LLVMC

public final class LLVMConstantInteger: LLVMValue {
    
    @inlinable
    public init(_ value: Bool, in context: LLVMContext) {
        super.init(
            _rawValue: LLVMConstInt(LLVMInt1TypeInContext(context._rawContext), value ? 1 : 0, 0),
            in: .context(context)
        )
    }
    
    @inlinable
    public init(_ value: UInt8, in context: LLVMContext) {
        super.init(
            _rawValue: LLVMConstInt(LLVMInt8TypeInContext(context._rawContext), UInt64(value), 0),
            in: .context(context)
        )
    }
    
    @inlinable
    public init(_ value: UInt16, in context: LLVMContext) {
        super.init(
            _rawValue: LLVMConstInt(LLVMInt16TypeInContext(context._rawContext), UInt64(value), 0),
            in: .context(context)
        )
    }
    
    @inlinable
    public init(_ value: UInt32, in context: LLVMContext) {
        super.init(
            _rawValue: LLVMConstInt(LLVMInt32TypeInContext(context._rawContext), UInt64(value), 0),
            in: .context(context)
        )
    }
    
    @inlinable
    public init(_ value: UInt64, in context: LLVMContext) {
        super.init(
            _rawValue: LLVMConstInt(LLVMInt64TypeInContext(context._rawContext), value, 0),
            in: .context(context)
        )
    }
}
