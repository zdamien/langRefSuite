#include "s.h"

template<typename T=int>
class point {
        T x;
        T y;
    public:
        point (T x, T y) : x(x), y(y) {};
        T getx() {return x;}
        T gety() {return y;}
};

template<typename T=int>
class point3 : point<T> {
    T z;
    public:
        point3(T x, T y, T z) : point<T>(x,y), z(z) {};
        T getz() {return z;}
};

int main() {
    point<> origin {0,0};
    point<> x {3,4};
    printf("%d\n",x.gety());
    x=origin;
    printf("%d\n",x.gety());

    vector<point<>> vp = {origin, x};
    vp.push_back (point<>(5,10));
    for (auto p: vp)
        printf("%d\n",p.gety());
    for (auto vi = vp.begin(); vi != vp.end(); vi++)
        printf("%d\n",vi->gety());

    point3<> z (1,2,3);
    printf("%d\n",z.getz());
}
