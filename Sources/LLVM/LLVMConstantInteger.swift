import LLVMC

public final class LLVMConstantInteger: LLVMConstant {
    
    @inlinable
    public init(words: [UInt64], type: LLVMIntegerType) {
        guard let wordCount = UInt32(exactly: words.count), wordCount > 0 else {
            preconditionFailure("Expected between 1 and \(UInt32.max) words, but got \(words.count)")
        }
        super.init(
            _rawValue: words.withUnsafeBufferPointer { buffer in
                LLVMConstIntOfArbitraryPrecision(type._rawType, wordCount, buffer.baseAddress)
            },
            in: .context(type.context)
        )
    }
}
