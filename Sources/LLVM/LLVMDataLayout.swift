import LLVMC

public final class LLVMDataLayout {

    @usableFromInline
    internal let _rawDataLayout: LLVMTargetDataRef

    @inlinable
    internal init(_rawDataLayout: LLVMTargetDataRef) {
        self._rawDataLayout = _rawDataLayout
    }

    @inlinable
    deinit {
        LLVMDisposeTargetData(_rawDataLayout)
    }

    @inlinable
    public var pointerSize: Int { Int(LLVMPointerSize(_rawDataLayout)) }
}

extension LLVMDataLayout: Equatable {

    @inlinable
    public static func == (lhs: LLVMDataLayout, rhs: LLVMDataLayout) -> Bool { lhs._rawDataLayout == rhs._rawDataLayout }
}

extension LLVMDataLayout: Hashable {

    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_rawDataLayout)
    }
}

extension LLVMDataLayout: CustomReflectable {

    @inlinable
    public var customMirror: Mirror { Mirror(self, children: [:]) }
}
