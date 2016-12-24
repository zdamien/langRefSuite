def outer():
    print("in outer")
    def inner():
        print ("in inner")
    inner()

outer()

#this fails as expected: NameError: name 'inner' is not defined
inner()
