import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph
 
class NetworkByteSwap extends Expr {
    NetworkByteSwap () {
        exists(
            MacroInvocation mi |

            mi.getExpr() = this |
                mi.getMacroName() = "ntohs"
            or  mi.getMacroName() = "ntohl"
            or  mi.getMacroName() = "ntohll" 
        )
    }
}
 
class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }

  override predicate isSource(DataFlow::Node source) {
    source.asExpr() instanceof NetworkByteSwap
  }
  override predicate isSink(DataFlow::Node sink) {
    exists(FunctionCall call_memcpy // such that...
        |    call_memcpy.getTarget().getName() = "memcpy"
        |    call_memcpy.getArgument(2) = sink.asExpr())
  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"