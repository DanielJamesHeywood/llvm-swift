import LLVMC

public final class LLVMStructureType: LLVMType {

    @inlinable
    public init(_ elementTypes: [LLVMType], isPacked: Bool = false, in context: LLVMContext) {
        precondition(
            elementTypes.allSatisfy { $0._context == context },
            "The element types are not all in the same context as the structure type"
        )
        var rawElementTypes = elementTypes.map { $0._rawType as LLVMTypeRef? }
        super.init(
            _rawType: rawElementTypes.withUnsafeMutableBufferPointer { buffer in
                guard let elementCount = UInt32(exactly: buffer.count) else {
                    preconditionFailure("Expected at most \(UInt32.max) element types, but got \(buffer.count)")
                }
                return LLVMStructTypeInContext(context._rawContext, buffer.baseAddress, elementCount, isPacked ? 1 : 0)
            },
            in: context
        )
    }
}
