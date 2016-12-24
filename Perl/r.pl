$x=1;

sub f {
    print $x, "\n";
}
sub g {
    print $x, "\n";
    $x=2;
}

sub h {
    my $x=$x;
    print $x, "\n";
}
f();
g();
f();
h();
