x=1

def f():
    print(x)

def g():
    global x
    print(x)
    x=2

def h():
    x=x
    print(x)

h()
