import time
called = False

def g():
    time=6
    def f():
        nonlocal time
        global called

        print ("before if: " + str(time))
        if not called:
            called = True

            time=5
            print ("in if: " + str(time))
            pass

        print ("after if: " + str(time))
        return
    f()
    print ("end of g: " + str(time))

g()
print ("top-level: " + str(time))
g()
