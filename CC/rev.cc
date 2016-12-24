#include "s.h"
#include <cctype>

string& oldrev_in_place(string &s) {
    auto start = s.begin(), end=s.end()-1;
    while (start < end) {
        swap(*start,*end);
        start++; end--;
    }
    return s;
}

auto& rev_in_place(auto &s) {
    auto start = s.begin(), end=s.end()-1;
    while (start < end) {
        swap(*start,*end);
        start++; end--;
    }
    return s;
}

void rev_in_place(auto start, auto end) {
    end=end-1;
    while (start < end) {
        swap(*start,*end);
        start++; end--;
    }
}

string& rev_words(string &s) {
    rev_in_place(s);
    auto start = s.begin();
    auto end = start;
    while (start < s.end()) {
        while (isspace(*start)) start++;
        end=start;
        while (end != s.end() && !isspace(*end)) end++;
        rev_in_place(start,end);
        start=end;
    }
    return s;
}

int main() {
    string s="hello";
    cout << s << ":" ; cout << rev_in_place(s) << "\n";
    s="world";
    cout << s << ":" ; cout << rev_in_place(s) << "\n";
    s="hello"; cout << s << ":";
    rev_in_place(s.begin(), s.end());
    cout << s << "\n";
    vector<int> v={1,2,3,4,5};
    pr_cont (v);
    rev_in_place(v.begin(),v.end());
    pr_cont (v);
    s="hello world"; cout << s << ":";
    rev_in_place(s.begin(), s.begin()+5);
    cout << s << "\n";
    pr_cont(s);

    s="hello world";
    cout << s << ":" ; cout << rev_words(s) << "\n";
    s=" hello  ";
    cout << s << ":" ; cout << rev_words(s) << "\n";
    cout << rev_words(s) << "\n";
    s="one two three ";
    cout << s << ":" ; cout << rev_words(s) << "\n";
 
}
