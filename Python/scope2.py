"""Python scoping weirdness"""

x=1

def f():
    print(x)

def g():
    """doesn't work: UnboundLocalError: local variable 'x' referenced
    before assignment"""
    print(x)
    x=2

f()
g()
