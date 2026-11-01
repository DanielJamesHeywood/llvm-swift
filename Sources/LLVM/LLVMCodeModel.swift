import LLVMC

public enum LLVMCodeModel: Hashable, Sendable {
    case `default`
    case justInTimeDefault
    case tiny
    case small
    case kernel
    case medium
    case large
}

extension LLVMCodeModel {

    @inlinable
    internal var _rawCodeModel: LLVMC.LLVMCodeModel {
        switch self {
        case .default:
            LLVMCodeModelDefault
        case .justInTimeDefault:
            LLVMCodeModelJITDefault
        case .tiny:
            LLVMCodeModelTiny
        case .small:
            LLVMCodeModelSmall
        case .kernel:
            LLVMCodeModelKernel
        case .medium:
            LLVMCodeModelMedium
        case .large:
            LLVMCodeModelLarge
        }
    }
}
