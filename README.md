FreeBSD port for Tensorflow 2

This is the development repository for
[science/libtensorflow2](https://www.freshports.org/science/libtensorflow2/).

Original patches from [this
bug](https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=258621)

# Usage

To install the dev release:

```
cd /usr/ports/science
git clone https://github.com/psa/libtensorflow2-freebsd-port libtensorflow1
cd libtensorflow2
make package
```

This takes a long time to build (~90 minutes with 4 Xeon E31275 @ 3.40GHz
cores) and 8+ GiB of RAM.
