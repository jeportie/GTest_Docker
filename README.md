# 📦 C++98 Google Test Docker Runner

This Dockerized test runner provides a zero-setup environment for building and executing C++98 projects with Google Test in the 42-school context. You write your code in `src/` and your tests in `test/`, and then run a single command to compile and see colored pass/fail output.

---

## 🛠️ Requirements

- Docker (Engine + CLI) installed on your machine  
- A C++ project targeting **C++98**  
- Project layout as described below  

---

## 🚀 Installation

1. **Clone this repository** (or add it as a Git submodule):
   ```bash
   git clone https://github.com/jeportie/gtest-docker.git
   cd gtest-docker
   ```

2. **Build the Docker image**:
   ```bash
   ./install.sh
   ```
   This script will:
   - Build an image named `gtest-runner`
   - Install a handy `runtest` wrapper into `/usr/local/bin` (or append it to your shell rc)

---

## 📂 Project Layout

Your C++98 project must follow:

```
.
├── src/                # Your `.cpp` and `.hpp` source files
│   ├── class/          # (optional) subdirectories
│   └── main.cpp        # entry point
│
├── test/               # All Google Test files
│   ├── class/          # test suites mirror your src structure
│   └── *Test.cpp       # e.g. AnimalTest.cpp, CatTest.cpp
│
├── CMakeLists.txt      # Top-level CMake config targeting C++98
└── build/              # (auto-mounted) CMake build output
```

---

## 🏃 Running Tests

Once `runtest` is installed, from **any** project root with the above layout:

```bash
runtest
```

This will:

1. Spin up the `gtest-runner` container (with `-it` for ANSI colors)  
2. Mount your project into `/project`  
3. Configure & build via CMake (using `-std=c++98 -Wall -Wextra -Werror`)  
4. Run `ctest` with colored pass/fail output  

You’ll see green/red results just like on a real terminal.

---

## ⚙️ Alias Details

If you ever need to inspect or modify the alias:

```bash
# On Ubuntu/Zsh: ~/.zshrc
# On Bash:       ~/.bashrc
$ grep runtest ~/.zshrc ~/.bashrc

# Or view the wrapper script directly:
$ cat /usr/local/bin/runtest
```

---

## ⚠️ 42-School & C++98 Notice

This container is **strictly configured** for the 42-school’s **C++98** norm:
- All compilations use `-std=c++98` and treat warnings as errors  
- Google Test integration is tailored to that standard  
- **Do not** attempt to compile C++11 or later code without adapting flags  

Use this runner when you need a compliant, reproducible test environment for piscine/projects at 42.

---

## 🎓 Further Reading

- [Google Test Primer](https://github.com/google/googletest)  
- [CMake Best Practices](https://cmake.org/cmake/help/latest/guide/tutorial/index.html)  
- [42-School C++ Norms](https://github.com/42Paris/cpp-pool/tree/master/cpp_module_00)  

---

> Crafted by jeportie • 2025  
```
