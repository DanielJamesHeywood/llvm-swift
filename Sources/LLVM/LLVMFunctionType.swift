import LLVMC

public final class LLVMFunctionType: LLVMType {

    @inlinable
    public init(returnType: LLVMType, parameterTypes: [LLVMType], isVariableArgument: Bool = false) {
        precondition(
            parameterTypes.allSatisfy { $0.context == returnType.context },
            "The parameter types are not all in the same context as the return type"
        )
        var rawParameterTypes = parameterTypes.map { $0._rawType as LLVMTypeRef? }
        super.init(
            _rawType: rawParameterTypes.withUnsafeMutableBufferPointer { buffer in
                guard let parameterCount = UInt32(exactly: buffer.count) else {
                    preconditionFailure("Expected at most \(UInt32.max) parameters, but got \(buffer.count)")
                }
                return LLVMC.LLVMFunctionType(
                    returnType._rawType,
                    buffer.baseAddress,
                    parameterCount,
                    isVariableArgument ? 1 : 0
                )
            },
            in: returnType.context
        )
    }
}
