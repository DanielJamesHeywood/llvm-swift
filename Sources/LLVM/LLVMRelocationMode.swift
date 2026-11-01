import LLVMC

public enum LLVMRelocationMode: Hashable, Sendable {
    case `default`
    case `static`
    case positionIndependentCode
    case dynamicNoPositionIndependentCode
    case readOnlyPositionIndependence
    case readWritePositionIndependence
    case readOnlyAndReadWritePositionIndependence
}

extension LLVMRelocationMode {

    @inlinable
    internal var _rawRelocationMode: LLVMRelocMode {
        switch self {
        case .default:
            LLVMRelocDefault
        case .static:
            LLVMRelocStatic
        case .positionIndependentCode:
            LLVMRelocPIC
        case .dynamicNoPositionIndependentCode:
            LLVMRelocDynamicNoPic
        case .readOnlyPositionIndependence:
            LLVMRelocROPI
        case .readWritePositionIndependence:
            LLVMRelocRWPI
        case .readOnlyAndReadWritePositionIndependence:
            LLVMRelocROPI_RWPI
        }
    }
}
