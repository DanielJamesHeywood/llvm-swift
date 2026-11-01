import LLVMC

public enum LLVMRelocationMode: Hashable, Sendable {
    case `default`
    case `static`
    case positionIndependent
    case dynamicPositionDependent
    case readOnlyPositionIndependent
    case readWritePositionIndependent
    case readOnlyAndReadWritePositionIndependent
}

extension LLVMRelocationMode {

    @inlinable
    internal var _rawRelocationMode: LLVMRelocMode {
        switch self {
        case .default:
            LLVMRelocDefault
        case .static:
            LLVMRelocStatic
        case .positionIndependent:
            LLVMRelocPIC
        case .dynamicPositionDependent:
            LLVMRelocDynamicNoPic
        case .readOnlyPositionIndependent:
            LLVMRelocROPI
        case .readWritePositionIndependent:
            LLVMRelocRWPI
        case .readOnlyAndReadWritePositionIndependent:
            LLVMRelocROPI_RWPI
        }
    }
}
