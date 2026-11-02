import LLVMC

public class LLVMConstant: LLVMValue {

    @inlinable
    public convenience init(elements: [LLVMConstant], type: LLVMStructureType) {
        precondition(
            elements.allSatisfy { $0._context == type._context },
            "The elements are not all in the same context as the structure type"
        )
        var rawElements = elements.map { $0._rawValue as LLVMValueRef? }
        self.init(
            _rawValue: rawElements.withUnsafeMutableBufferPointer { buffer in
                guard let elementCount = UInt32(exactly: buffer.count) else {
                    preconditionFailure("Expected at most \(UInt32.max) elements, but got \(buffer.count)")
                }
                return LLVMConstNamedStruct(type._rawType, buffer.baseAddress, elementCount)
            },
            in: elements.reduce(.context(type._context)) { $0.intersection($1._container) }
        )
    }
}
