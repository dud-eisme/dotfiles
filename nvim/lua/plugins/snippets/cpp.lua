local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("cf", {
    t({
      "#include <bits/stdc++.h>",
      "using namespace std;",
      "",
      "void solve() {",
      "    "
    }),
    i(1),
    t({
      "",
      "}",
      "",
      "int main() {",
      "    ios::sync_with_stdio(false);",
      "    cin.tie(nullptr);",
      "",
      "    int t;",
      "    cin >> t;",
      "    while (t--) {",
      "        solve();",
      "    }",
      "    return 0;",
      "}"
    }),
  }),
  s("lab", {
    t({
      "#include <iostream>",
      "using namespace std;",
      "",
      "int main() {",
      "  ",
    }),
    i(1),
    t({
      "",
      "  return 0;",
      "}"
    }),
  }),}
