#nested function isn't hidden

sub outer {
    print "in outer\n";
    sub inner {
        print "in inner\n";
    }
    inner();
}

outer();
inner();


