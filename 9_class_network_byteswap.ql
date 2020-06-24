import cpp
// from MacroInvocation mi
// where mi.getMacroName() = "ntohs"
// or mi.getMacroName() = "ntohl"
// or mi.getMacroName() = "ntohll"
// select mi.getExpr()

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

from NetworkByteSwap nbs select nbs