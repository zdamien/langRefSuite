// Load the environment with useful things, kind of like what comes by
// default with Perl.

#include <algorithm>
#include <iostream>
#include <vector>
#include <deque>
#include <string>
#include <cstring>
#include <iterator>
#include <list>
#include <map>
#include <cassert>
#include <unordered_map>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
using namespace std;

template<class T>
void pr_vector(const vector <T> &v) {
    for (auto i : v)
        cout << i;
    cout << "\n";
}
template<class T>
void pr_deque(const deque <T> &v) {
    for (auto i : v)
        cout << i;
    cout << "\n";
}

void pr_cont(const auto &c) {
    for (auto i : c)
        cout << i;
    cout << "\n";
}

void pr_cont2(const auto &c1) {
    for (auto c2 : c1) {
        for (auto i : c2)
            cout << i;
        cout << "\n";
    }
}

std::ostream& operator<<(std::ostream& os, const pair<auto, auto>& p) {
    os << p.first << ":" << p.second << "\n";
}

void pr_cpair(const auto &c1) {
    for (auto p : c1) {
        cout << p.first << ":" << p.second << "\n";
    }
}

auto max1(const auto& v1, const auto& v2) {
    if (v1 > v2) return v1;
    else return v2;
}

auto max1(const auto& c) {
    auto m=c.front();
    for (const auto &i : c) {
        if (i > m) m=i;
    }
    return m;
}

auto max2(const auto& b, const auto& e) {
    auto m = *b;
    auto i = b;
    while (i<e) {
        if (*i > m) m=*i;
        i++;
    }
    return m;
}
