import LLVMC

public enum LLVMRelocationMode: Hashable, Sendable {
    case `default`
    case `static`
    case positionIndependence
    case dynamicNoPositionIndependence
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
        case .positionIndependence:
            LLVMRelocPIC
        case .dynamicNoPositionIndependence:
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
