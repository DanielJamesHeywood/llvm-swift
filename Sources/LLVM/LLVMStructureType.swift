import LLVMC

public final class LLVMStructureType: LLVMType {

    @inlinable
    public init(_ name: String, elementTypes: [LLVMType], isPacked: Bool = false, in context: LLVMContext) {
        precondition(
            !name.contains("\0"),
            "Unexpected character '\\0' in '\(name.debugDescription.dropFirst().dropLast())'"
        )
        precondition(
            elementTypes.allSatisfy { $0._context == context },
            "The element types are not all in the same context as the structure type"
        )
        super.init(_rawType: LLVMStructCreateNamed(context._rawContext, name), in: context)
        var rawElementTypes = elementTypes.map { $0._rawType as LLVMTypeRef? }
        rawElementTypes.withUnsafeMutableBufferPointer { buffer in
            guard let elementCount = UInt32(exactly: buffer.count) else {
                preconditionFailure("Expected at most \(UInt32.max) element types, but got \(buffer.count)")
            }
            LLVMStructSetBody(_rawType, buffer.baseAddress, elementCount, isPacked ? 1 : 0)
        }
    }
}
