import LLVMC

public final class LLVMConstantStructure: LLVMValue {

    @inlinable
    public init(elements: [LLVMValue], type: LLVMStructureType) {
        precondition(
            elements.allSatisfy { $0._context == type._context },
            "The elements are not all in the same context as the structure type"
        )
        var rawElements = elements.map { $0._rawValue as LLVMValueRef? }
        let rawValue = rawElements.withUnsafeMutableBufferPointer { buffer -> LLVMValueRef in
            guard let elementCount = UInt32(exactly: buffer.count) else {
                preconditionFailure("Expected at most \(UInt32.max) elements, but got \(buffer.count)")
            }
            return LLVMConstNamedStruct(type._rawType, buffer.baseAddress, elementCount)
        }
        super.init(_rawValue: rawValue, in: .context(type._context))
    }
}
