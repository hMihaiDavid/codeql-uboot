import cpp

from FunctionCall c //, Function f
//where c.getTarget() = f
//and f.getName() = "memcpy"
where c.getTarget().getName() = "memcpy"
select c
