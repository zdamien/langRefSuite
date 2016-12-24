#include "s.h"

int main() {
    vector<int> sv={1,2,3};
    pr_cont(sv);
    list<string> lv={"one","two","three"};
    pr_cont(lv);
    deque<char> dv={'A','B','C'};
    pr_cont(dv);
    deque<int> di={4,5,6};
    pr_cont(di);

    vector<vector<int>> vpp = {{1,2},{3,4}};
    pr_cont2(vpp);

    printf("%d\n",max1(3,4));
    printf("%g\n",max1(4.1,3.2));
    cout << max1("the","Cat") << "\n";
    cout << max1("there","the") << "\n";
    cout << max1(lv) << "\n";
    cout << max1(dv) << "\n";
    cout << max2(sv.begin(),sv.end()) << "\n";
    cout << max2(dv.begin(),dv.end()) << "\n";
    cout << max2(di.begin(),di.end()) << "\n";
    //cout << max2(lv.begin(),lv.end()) << "\n";  //doesn't work
    cout << "\n";
    string s{"Hello world"};
    cout << s[0] << "\n";
    map <int,string> m = {{1,"one"},{2,"two"}};
    pr_cpair(m);
    pr_cont(m);
}
