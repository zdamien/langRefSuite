sub outer {
    sub inner {
        print "inside inner\n";
    }
    print "inside outer\n";
}

outer();
inner();
