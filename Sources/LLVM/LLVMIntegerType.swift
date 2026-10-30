import LLVMC

public final class LLVMIntegerType: LLVMType {
    
    @inlinable
    public init(bitWidth: Int, in context: LLVMContext) {
        precondition(1...8388608 ~= bitWidth, "Expected a bit width between 1 and 8388608, but got \(bitWidth)")
        super.init(_rawType: LLVMIntTypeInContext(context._rawContext, UInt32(bitWidth)), in: context)
    }
}
