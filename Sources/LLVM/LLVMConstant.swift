import LLVMC

public class LLVMConstant: LLVMValue {
    
    @inlinable
    public convenience init(elements: [LLVMConstant], type: LLVMStructureType) {
        precondition(
            elements.allSatisfy { element in element.context == type.context },
            "The elements are not all in the same context as the structure type"
        )
        var rawElements = elements.map { element in element._rawValue as LLVMValueRef? }
        self.init(
            _rawValue: rawElements.withUnsafeMutableBufferPointer { buffer in
                guard let elementCount = UInt32(exactly: buffer.count) else {
                    preconditionFailure("Expected at most \(UInt32.max) elements, but got \(buffer.count)")
                }
                return LLVMConstNamedStruct(type._rawType, buffer.baseAddress, elementCount)
            },
            in: elements.reduce(.context(type.context)) { container, element in
                container.intersection(element._container)
            }
        )
    }
}
