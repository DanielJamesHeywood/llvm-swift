import LLVMC

public enum LLVMCodeGenerationOptimizationLevel: Hashable, Sendable {
    case none
    case less
    case `default`
    case aggressive
}

extension LLVMCodeGenerationOptimizationLevel {

    @inlinable
    internal var _rawCodeGenerationOptimizationLevel: LLVMCodeGenOptLevel {
        switch self {
        case .none:
            LLVMCodeGenLevelNone
        case .less:
            LLVMCodeGenLevelLess
        case .default:
            LLVMCodeGenLevelDefault
        case .aggressive:
            LLVMCodeGenLevelAggressive
        }
    }
}
