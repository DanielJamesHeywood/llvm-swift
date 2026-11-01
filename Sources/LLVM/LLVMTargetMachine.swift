import LLVMC

public final class LLVMTargetMachine {

    @usableFromInline
    internal let _rawTargetMachine: LLVMTargetMachineRef

    @inlinable
    public init(
        target: LLVMTarget,
        triple: String,
        cpu: String = "",
        features: String = "",
        optimizationLevel: LLVMCodeGenerationOptimizationLevel = .default,
        relocationMode: LLVMRelocationMode = .default,
        codeModel: LLVMCodeModel = .default
    ) {
        self._rawTargetMachine = LLVMCreateTargetMachine(
            target._rawTarget,
            triple,
            cpu,
            features,
            optimizationLevel._rawCodeGenerationOptimizationLevel,
            relocationMode._rawRelocationMode,
            codeModel._rawCodeModel
        )
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
