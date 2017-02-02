"""Python scoping weirdness"""

x=1

def f():
    """doesn't work: UnboundLocalError: local variable 'x' referenced before
    assignment"""
    x=x
    print (x)

f()
