@usableFromInline
internal enum _Container {
    case context(LLVMContext)
    case module(LLVMModule)
}

extension _Container {
    
    @inlinable
    internal var context: LLVMContext {
        switch self {
        case let .context(context):
            context
        case let .module(module):
            module._context
        }
    }
    
    @inlinable
    internal func intersection(_ other: _Container) -> _Container {
        switch (self, other) {
        case let (.context(context), .context(otherContext)):
            precondition(context == otherContext, "The contexts are not the same")
            return .context(context)
        case let (.context(context), .module(module)), let (.module(module), .context(context)):
            precondition(module._context == context, "The module is not in the context")
            return .module(module)
        case let (.module(module), .module(otherModule)):
            precondition(module == otherModule, "The modules are not the same")
            return .module(module)
        }
    }
}
