import LLVMC

public final class LLVMTargetMachine {

    @usableFromInline
    internal let _rawTargetMachine: LLVMTargetMachineRef

    @inlinable
    public init(target: LLVMTarget, triple: String) {
        let options = LLVMCreateTargetMachineOptions() as LLVMTargetMachineOptionsRef
        self._rawTargetMachine = LLVMCreateTargetMachineWithOptions(target._rawTarget, triple, options)
        LLVMDisposeTargetMachineOptions(options)
    }

    @inlinable
    deinit {
        LLVMDisposeTargetMachine(_rawTargetMachine)
    }
}

extension LLVMTargetMachine: Equatable {

    @inlinable
    public static func == (lhs: LLVMTargetMachine, rhs: LLVMTargetMachine) -> Bool {
        lhs._rawTargetMachine == rhs._rawTargetMachine
    }
}

extension LLVMTargetMachine: Hashable {

    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_rawTargetMachine)
    }
}

extension LLVMTargetMachine: CustomReflectable {

    @inlinable
    public var customMirror: Mirror { Mirror(self, children: [:]) }
}
