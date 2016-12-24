#Language basics:
#comparisons and if tests
#loops, for, while, sequence iteration.

use strict; # a good idea, and advantage over Python

sub control {
    if (3<4) {
        ;
    } else {
        die 
    }
    die if 3>4;
    my $i=0;
    my $acc=0;
    while ($i<10) {
        $acc+=$i;
    }
    continue { #rarely used, executed by normal loop or by next
        $i++;
    }
    die if $acc!=45;
    for ($i=0, $acc=0; $i<10; $i++) {
        $acc+=$i;
    }
    die if $acc!=45;
    $acc=0;
    for $i (0..9) {
    #could also call it foreach
    # .. operator is inclusive
    # Perl 0..9 == Python list(range(10))
        $acc+=$i;
    }
    die if $acc!=45;
    # .. is like Python 2 range, makes a list
    my @list= 0..9;
    die if $list[0] != 0;
    die if $list[9] != 9;

}
#math. modular, power, complex

sub math {
    die if 5/3 == 1; #float by default
    die if 5%3 != 2;
    {
        use integer;
        die if 5/3 != 1;
        #also % may be faster but undefined for negative input
    }
    die if 2**3 !=8;
    die if -2**2 !=-4;  # ** higher precedences than -
    die if (-2)**2 !=4;
    die unless 4**0.5 == 2;
    die unless 2**-1 == 0.5;
    die unless 4**-0.5 == 0.5;
    print sin(3.14159/6),"\n";  #no math module needed, just use it!
     #also no default newline
     print (1+2),"\n";  # function call, ignores the stuff after )
     print +(1+2),"\n";  # 
    print log(10);  #no math module, just use it!
}

#strings, create, compare, modify, copy.

sub strings{
    die if ("o" x 3) ne "ooo";  # string multiplication
    die if "horse" ne "horse";
    die if "horse" eq "cat";
    #die if "horse" != "cat";  #runs but wrong; math conversion from op
    die if " 33 " eq "033";  #unequal strings
    die if " 33 " != "033";  #equal numbers
    my $s="hello";
    # $s[0]="H"; #nope
    $s =~ s/h/H/;
    die unless $s eq "Hello";
    my $z = substr $s, length($s), 0, " world";
    die unless $s eq "Hello world";
    print "\n$z:$s\n";
    $z = substr ($s, 0, 6) . "Vegas!";
    print "\n$z:$s\n";
    die unless index ($s,"H") == 0;
    print <<HERE;
Here document
Second line
HERE
    $s = "hello";
    die if $s . " world" ne "hello world"; # . not +
    die unless "   0003 " + "02\n" == 5;
    my @w = split /\s/, "hello world";
    print "uh ", scalar @w,"\n";
    $s = "hello" . "world";  #concatenation operator
    die unless $s eq "helloworld";
}
#functions, closures, function objects
sub functest {
     #basic parameters
    sub func1 {
        my ($one, $two)= @_;
        print "$two $one\n";
    }
    func1 "hello","world" ;

     #closures
    sub closure {
        my $o = shift;
        return sub {my $x=shift; return $x+$o;};
    }
    my $c1 = closure(4);  #closure as subroutine reference
    die unless &$c1(1) == 5;
    die unless $c1->(3) == 7;
    my $c2 = closure(-2);
    die unless &$c2(1) == -1;

    {
        my $shared=0;
        sub inc { $shared++;}
        sub dec { $shared--;}
        sub getshared { $shared; }
    }
    inc; inc;  #don't always need () to call
    #also note the inc and dec functions aren't bound to that scope
    #print "$shared\n"; #but $shared is
    die unless getshared == 2;
    dec();
    die unless getshared() == 1;

     #arguments and return values by reference, since lists just get
     #jammed together
    my @l1=(1,2,3);
    my $l2=[4,5,6];
    sub reftest {
        my $l1=shift;
        my $l2=shift;
        my @ret = (@$l2 , @$l1);
        return \@ret, "dummy";
    }
    my ($l3, $s) = reftest(\@l1, $l2);
    #need (); 'my $l3, $s' applies the my only to $l3
    print "reft: @$l3 : $s\n";
}

print "test\n";
func1 "sugar","spice" ;  #nested functions aren't bound to their scope!
print "test\n";

#arrays or lists
# initialize, copy, resize, split
#maps
sub arrayHash {
    my @a=(1,2,3);
    die unless $a[0]==1;
    die unless $a[2]==3;
    die unless $#a==2; #last valid index
    die unless scalar(@a) == 3; #length
    print @a,"\n";

    $#a = 10;  #resizes array
    print @a,"\n";
    $a[10]="end";
    print @a,"\n";
    $#a = 1;
    print @a,"\n";

    my %h= (one => 1, two => 2);  # => is like comma but quotes left barewords
    die unless $h{one} == 1;
    $h{three}++;   #new keys default to value of 0 or ""
    die unless $h{three} == 1;
    $h{hello} .= "world";
    die unless $h{hello} eq "world";
    print %h,"\n";

     #one standard hash iteration idiom.  (sort keys %h) for sorted.
    for my $k (keys %h) {
        printf "$k: $h{$k}; ";
    }
     # keys %h = 200 #to tell it how many buckets to have
    printf "\n";
    my ($k, $v);
     #another idiom
    while (($k, $v) = each %h) { #need ($k,$v), not $k,$v
        printf "$k: $v; ";
    }
    printf "\n";
    for $v (values %h) {
        $v = "$v$v"; #returns actual values to modify, not just a copy
    }
    while (($k, $v) = each %h) { #need ($k,$v), not $k,$v
        printf "$k: $v; ";
    }
    print "\n";
    undef $h{hello}; #undefines the value but leaves the key
    delete $h{one}; #fully removes the element
    while (($k, $v) = each %h) { #need ($k,$v), not $k,$v
        printf "$k: $v; ";
    }

    printf "\n";
    #die unless @a == @a; 
     # no simple comparison operator for arrays
}

#multiple dimensional arrays
#
#More language:
#bits
#array of maps, map of arrays, map of maps
#priority queue
#objects
#assertion
#library sort, search
sub sortSearch {
    # Perl doesn't have a binsearch function! wtf
     #just Search::Dict for textfiles
    my @a=(4,2,3,5,0);
    print sort @a,"\n";
    print reverse @a,"\n";
}
#applicative functions

sub applic {
    my @a=(1..3);
    my @b = map {$_*$_} @a;
    print "\n",@b,"\n";
    @b = grep {$_%2} @a;
    print "\n",@b,"\n";
}

#handrolled sort
#exceptions or errors
#regular expressions
#threads, locks
#package or modules, build
#
#Basic IO:
#console io: read, write, error
#file io: file existence, creation, reading, writing, deletion
#get time
#get random numbers
#get date
#
#More IO
#directory
#sockets and networking
#database access
#link against libraries

sub main {
    control();
    math();
    strings();
    functest();
    arrayHash();
    sortSearch();
    applic();

}

main();
