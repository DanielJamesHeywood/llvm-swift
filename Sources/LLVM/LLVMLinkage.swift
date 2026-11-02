import LLVMC

public enum LLVMLinkage: Hashable, Sendable {
    case external
    case availableExternally
    case linkOnceAny
    case linkOnceOneDefinitionRule
    case weakAny
    case weakOneDefinitionRule
    case appending
    case `internal`
    case `private`
    case externalWeak
    case common
}

extension LLVMLinkage {

    @inlinable
    internal var _rawLinkage: LLVMC.LLVMLinkage {
        switch self {
        case .external:
            LLVMExternalLinkage
        case .availableExternally:
            LLVMAvailableExternallyLinkage
        case .linkOnceAny:
            LLVMLinkOnceAnyLinkage
        case .linkOnceOneDefinitionRule:
            LLVMLinkOnceODRLinkage
        case .weakAny:
            LLVMWeakAnyLinkage
        case .weakOneDefinitionRule:
            LLVMWeakODRLinkage
        case .appending:
            LLVMAppendingLinkage
        case .internal:
            LLVMInternalLinkage
        case .private:
            LLVMPrivateLinkage
        case .externalWeak:
            LLVMExternalWeakLinkage
        case .common:
            LLVMCommonLinkage
        }
    }
}
