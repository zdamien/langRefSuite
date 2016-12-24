import time

called = False
def f():
    global called, time

    print "before if: " + str(time)
    if not called:
        called = True

        time=5
        print "in if: " + str(time)
        pass

    print "after if: " + str(time)
    return

f()
print "top-level: " + str(time)
f()
