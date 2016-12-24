def outer():
    def inner():
        print("inside inner")

    print("inside outer")

outer()
inner()
