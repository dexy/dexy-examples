# Example adapted from:
# https://docs.einsteinpy.org/en/latest/examples/Predefined%20Metrics%20in%20Symbolic%20Module.html

### "imports"
from einsteinpy.symbolic import RicciScalar
from einsteinpy.symbolic.predefined import AntiDeSitter
from einsteinpy.symbolic.predefined import DeSitter
from einsteinpy.symbolic.predefined import Minkowski
from einsteinpy.symbolic.predefined import Schwarzschild
from sympy import latex
from sympy import simplify
import einsteinpy.symbolic.predefined
import json
import sympy

snippets = {}

### "metrics-list"
snippets['predefined'] = {}
for k, v in einsteinpy.symbolic.predefined.__dict__.items():
    if callable(v):
        snippets['predefined'][k] = {
                "name" : v.__name__,
                "qualname" : v.__qualname__,
                "docs" : v.__doc__.split("Parameters")[0].strip()
                }

### "custom-pprint"
def pprint(expr):
    # unicode doesn't always play nicely with LaTeX
    sympy.pprint(expr, use_unicode=False)

### "Schwarzschild"
sch = Schwarzschild()
t = sch.tensor()
pprint(t)
### @end
assert isinstance(sch, einsteinpy.symbolic.metric.MetricTensor)
snippets['Schwarzschild'] = latex(t)

### "Minkowski"
mink = Minkowski(c=1)
t = mink.tensor()
pprint(t)
### @end
assert isinstance(sch, einsteinpy.symbolic.metric.MetricTensor)
snippets['Minkowski'] = latex(t)

### "DeSitter"
mink = DeSitter()
t = mink.tensor()
pprint(t)
### @end
assert isinstance(sch, einsteinpy.symbolic.metric.MetricTensor)
snippets['DeSitter'] = latex(t)

### "AntiDeSitter"
mink = AntiDeSitter()
t = mink.tensor()
pprint(t)
### @end
assert isinstance(sch, einsteinpy.symbolic.metric.MetricTensor)
snippets['AntiDeSitter'] = latex(t)

### "Ricci-curvatures"
scalar_curvature_de_sitter = RicciScalar.from_metric(DeSitter())
scalar_curvature_anti_de_sitter = RicciScalar.from_metric(AntiDeSitter())
### @end
snippets['DeSitter-curvature'] = latex(scalar_curvature_de_sitter.expr)
snippets['AntiDeSitter-curvature'] = latex(scalar_curvature_anti_de_sitter.expr)
snippets['AntiDeSitter-simplified'] = latex(simplify(scalar_curvature_anti_de_sitter.expr))

### "save-latex"
with open("snippets.json", 'w') as f:
    json.dump(snippets, f)
