import LLVMC

public final class LLVMPoisonValue: LLVMConstant {

    @inlinable
    public init(type: LLVMType) {
        super.init(_rawValue: LLVMGetPoison(type._rawType), in: .context(type._context))
    }
}
