#Python 3
#Language basics:
#comparisons and if tests
#loops, for, while, sequence iteration.
def control():
    assert 3<4
    assert 3<=4
    assert 4<=4
    assert "hello" == "hello"
    assert not 3<2
    assert -1<1<2
    if 3<4:
        assert True
    else:
        assert False
    acc=0
    for i in range(10): #end not included, unlike Perl
        acc+=i
    assert acc == 45
    assert sum(range(10))==45
    assert max(range(10))==9
    assert min(range(10))==0
    i, acc = 0,0
    while i<10:
        acc+=i
        i+=1
    assert acc == 45
    assert i == 10
    acc=0
    for i in range(1,7,2): #1,3,5
        acc+=i
    assert acc == 9
    acc=0
    for i in range(7,1,-2): #7, 5, 3
        acc+=i
    assert acc == 15

    print("control() ok")

#math. modular, power, complex
from math import *
import cmath
def mathTest():
    assert 1 == 5//3  # // is integer division
    assert 2 == 5%3
    assert type(4/2)==float
    assert type(4//2)==int
    assert 2**3 == 8
    assert 2.0**3 == 8.0
    assert sqrt(4)==2
    assert cmath.sqrt(4)==2
    assert cmath.sqrt(4)==(2+0j)
    assert cmath.sqrt(-1)==(1j)
    assert sin(pi/2)==1
    assert 4**.5==2  #fractional exponents okay
    assert 4**-1==0.25  #negative exponents okay
    assert 4**-.5==0.5  
    print("mathTest() ok")

#strings, create, compare, modify, copy.
def stringTest():
    s=str()
    assert s == ""
    s="hello"
    #s[0] = 'H' # modification not allowed
    s = 'H'+s[1:]
    assert s=="Hello"
    assert s[2:3]=="l"
    assert s[-1]=="o"
    assert len(s) == 5
    ss=s
    assert s==ss
    assert s.find("H")==0
    assert s.find("o")==4
    assert s.find("a")==-1
    assert s.find("el")==1
    assert s.upper() == "HELLO"
    assert "4".zfill(2)=="04"
    s=" The quick brown fox "
    assert s.split() == ["The","quick","brown","fox"]
    s=" The,quick,brown,fox "
    assert s.split(sep=',') == [" The","quick","brown","fox "]
    s=" The,,quick,,brown,,fox "
    assert s.split(sep=',,') == [" The","quick","brown","fox "]
    s="The\nquick"
    assert s.splitlines() == ["The","quick"]
    assert s.replace("The","One")=="One\nquick"
    s="Hello"
    assert sorted(s.lower())==['e', 'h', 'l', 'l', 'o']
    print("stringTest() ok")

#functions, closures, function objects
def functest():
    def nest():
        return 4
    assert nest()==4
    def closure(o):
        return lambda x:x+o
    c1=closure(1)
    c2=closure(2)
    assert c1(3)==4
    assert c2(3)==5
    assert c2(3)!=3
    def params(a=0, b=1):
        return a+b
    assert params() == 1
    assert params(1) == 2
    assert params(a=2, b=3) == 5
    assert params(b=2, a=3) == 5
    print("functest() ok")

#arrays or lists
# initialize, copy, resize, split
#multiple dimensional arrays
def listtest():
    a=list()
    b=[]
    assert a==b
    a.append(1)
    a.append(2)
    a.append(3)
    assert a==[1,2,3]
    assert len(a)==3
    a.clear()
    assert a==[]
    a=[1,2,3]
    b=a  #list values are references
    assert a is b #object identity
    a[0]=10
    assert b==[10,2,3]
    a=b[:]  #copy
    assert not a is b
    a[0]=1
    assert b==[10,2,3]
    assert a==[1,2,3]
    assert a.index(3)==2
    assert a.pop()==3  #remove end
    assert a==[1,2]
    assert a.pop(0)==1  #remove specific indexed element
    assert a==[2]
    c=[2]*4
    assert c==[2,2,2,2]
    c=[2,3,2,3]
    c.remove(3) #remove first instance of value
    assert c==[2,2,3]
    c=[4,3,2,1]
    assert sorted(c)==[1,2,3,4]
    assert c==[4,3,2,1]
    c.sort()
    assert c==[1,2,3,4]
#also reversed and list.reverse()
    acc=0
    for i in c:  #local idiom
        acc+=i
    assert acc==10
    acc=0
    for i in range(len(c)):  #painful
        acc+=c[i]
    assert acc==10
    for i,v in enumerate(c):  #when you need the index
        assert i==v-1

    #multiple
    a=[0]*4
    assert a==[0,0,0,0]
    for i,v in enumerate(a):
        a[i]=[i]*3
    assert a==[[0, 0, 0], [1, 1, 1], [2, 2, 2], [3, 3, 3]]
    a[0][1]=10
    assert a==[[0, 10, 0], [1, 1, 1], [2, 2, 2], [3, 3, 3]]
    print("listtest() ok")
    
    
#maps. dictionaries in python.
def maptest():
    m={}
    m[1]="one"
    m[2]="two"
    assert m[1]=="one"
    print(m)
    m2=m
    m3=m.copy()
    m.clear()
    assert m == dict()  #can't do m.clear() == dict()
    assert m2 == dict()  #can't do m.clear() == dict()
    print(m3)
    m=m3
    m[3]=0
    m[3]+=1
    assert m[3]==1
    #can't do m[4]+=1; no default value in default dicts
    print(m.get(4,20)) #access with default provided (20)
    m.setdefault(3,20)  #doesn't affect 3
    m.setdefault(4,20) #sets 4:20
    print(m)
    #still can't do m[4]+=1
    print(m.keys()) #keys
    for k in m.keys():
        print(k)
    print(m.items())
    for k,v in m.items():
        print(k,":",v)  
    #item removal:
    assert m.pop(3)==1 #remove specific item
    assert m.pop(5,12)==12  #remove possible item, with default
    print( m.popitem())  #pops unspecified item, returning (k,v) tuple
    print("maptest() ok")

#
#More language:
#bits
def bittest():
    def countbits(n):
        bits=0
        while (n>0):
            if n&1: bits+=1
            n>>=1
        return bits
    assert(countbits(4)==1)
    assert(countbits(0)==0)
    assert(countbits(1)==1)
    assert(countbits(7)==3)
    assert(countbits(6)==2)
    assert 4|2==6
    assert 6^2==4
    assert 4&2==0
    print("bittest() ok")
        
#array of maps, map of arrays, map of maps
def complexstructures():
    a=[]
    a.append({})
    a.append(dict())
    a[0][1]="one"
    a[1][1]="uno"
    assert a==[{1: 'one'}, {1: 'uno'}]
    assert str(a)=="[{1: 'one'}, {1: 'uno'}]"
    print(a)
    m={}
    m["engL"]=[1,2,3]
    m["spaL"]=["uno", "dos"]
    m["junM"]={4:"quattro","cinco":5}
    print(m)
    #map of arrays and a map. possibly you shouldn't do this, but you can!
    from collections import defaultdict
    dd=defaultdict(int)  #need to provide a function for default value
    dd[4]+=1
    assert dd[4]==1
    assert dd[5]==0

    from collections import deque
    q=deque()
    q.append(2)
    q.appendleft(1)
    q.append(3)
    q.rotate(-1)
    print(q)
    assert q==deque([2, 3, 1])

#priority queue / heap
    import heapq #heaps are just lists
    h=list(range(10,0,-1))
    heapq.heapify(h)
    heapq.heappush(h,11)
    heapq.heappush(h,0)
    assert h==[0, 2, 1, 3, 6, 4, 8, 10, 7, 9, 11, 5]
    heapq.heapreplace(h,-1)
    assert h==[-1, 2, 1, 3, 6, 4, 8, 10, 7, 9, 11, 5]
    heapq.heappushpop(h,-2)
    assert h==[-1, 2, 1, 3, 6, 4, 8, 10, 7, 9, 11, 5]
    print("complexstructures() ok")



#objects
def objecttest():
    class Complex:
        def __init__(self,re=0, im=0):
            self.re=re
            self.im=im
        def __str__(self):
            return str(self.re)+"+"+str(self.im)+"i"
        #need both the next two to hash properly based on value
        def __hash__(self):
            return hash(self.re+self.im)
        def __eq__(self,other):
            return self.re==other.re and self.im==other.im
    print(Complex())
    print(Complex(2,3))
    d={}
    d[Complex()]=0
    d[Complex()]+=1  #same hash value, despite new object
    assert d[Complex()] == 1

    class Conj(Complex):  #simple child object
        def __init__(self,re=0, im=0):
            Complex.__init__(self,re,im)
            self.im=-im
    print(Conj(4,3))
    assert (Conj(4,3)==Complex(4,-3))
    assert str(Conj(4,3))=="4+-3i"
    print("objecttest() ok")

#library sort, search
#operator modules has itemgetter, attrgetter, for easier key use in sorts
#sorted(student_tuples, key=itemgetter(1,2)) to sort on fields 1, then 2
#sorted(student_objects, key=attrgetter('grade', 'age'))
#sorted(student_objects, key=attrgetter('age'), reverse=True)
# sorts stable (Timsort, some unholy mutation of mergesort)
#Py2 uses cmp
def sortAndSearch():
    import bisect
    a=list(range(0,30))
    i=bisect.bisect_left(a,25)
    assert i==25
    bisect.insort_left(a,0)
    i=bisect.bisect_right(a,0)
    assert i==2  #insection point after [0,0...]
#https://docs.python.org/3/library/bisect.html#searching-sorted-lists
#    for search recipes
    print("sortAndSearch() ok")


#applicative functions
def applic():
    arr=list(range(1,4))
    arr2= list(map( lambda x: x*x, arr))
    assert(arr2 == [1,4,9])
    arr2= list(filter( lambda x: x%2, arr))
    assert(arr2 == [1,3])
    import functools
    s=functools.reduce(lambda x, y: x+y, arr, 0)
     #third argument is optional initializer
    assert(s == 6)
    print("applic() ok")

#handrolled sort
#exceptions or errors
def exceptions():
    try:
        x=2/0
    except (ZeroDivisionError, Exception) as e:
        assert(str(e) == "division by zero")
    except: #catch all exceptions, bad practice
        pass
    else:
        print("result is",x)
    finally:
        pass #if we had anything to clean up

    class MyExcept(Exception):
        def __str__(self):
            return "MyExcept"
    try:
        raise MyExcept
    except MyExcept as e:
        assert(str(e) == "MyExcept")
    finally:
        assert(True) #for cleanup actions no matter what
    print("exceptions() ok")

#regular expressions
#threads, locks
#package or modules, build
#
#Basic IO:
#console io: read, write, error
def consoleIO():
    inp=input()
    print(inp)

    import sys
#    for l in sys.stdin:
#        print(l)   #two newlines
#    for l in sys.stdin:
#        print(l.rstrip())  #one newline
    for l in sys.stdin:
        print(l,end='')  #one newline
    print("consoleIO() ok")


#file io: file existence, creation, reading, writing, deletion
def fileIO():
    with open("tmp","w") as f:
        print("hello, tmp\ngoodbye",file=f)
    with open("tmp","r") as f:
        for l in f:
            print(l)
    print("fileIO() ok")

#get time
#get random numbers

def timeAndRandom():
    import time
    print(time.time())
    time.sleep(0.1) #seconds
    print(time.time())

    import random
    nums=[]
    for i in range(18):
        nums.append(random.randint(1,6))
    print("rand: ",nums)
    print("random float [0,1) ", random.random()) #float 0..1
    print("timeAndRandom() ok")

#get date
#
#More IO
#directory
#sockets and networking
#database access
#link against libraries

def main():
    control()
    mathTest()
    stringTest()
    functest()
    listtest()
    maptest()
    bittest()
    complexstructures()
    applic()
    exceptions()
    objecttest()
    sortAndSearch()
    #consoleIO()
    fileIO()

    timeAndRandom()

main()
