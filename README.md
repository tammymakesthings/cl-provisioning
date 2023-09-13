# cl-provisioning

Common Lisp Machine Provisioning

# Usage

Run from sources:

    make run
    # aka sbcl --load run.lisp

choose your lisp:

    LISP=ccl make run

or build and run the binary:

```
$ make build
$ ./cl-provisioning [name]
Hello [name] from cl-provisioning
```

## Init config file

Create a config file:

    cp config-example.lisp config.lisp

You can override global variables (for example, the port, which can be
handy if you run the app from sources, without building a binary and
using the `--port` flag.

The config file is `load`ed before the web server starts (see the `(main)`).


## Roswell integration

Roswell is an implementation manager and [script launcher](https://github.com/roswell/roswell/wiki/Roswell-as-a-Scripting-Environment).

A POC script is in the roswell/ directory.

Your users can install the script with `tammymakesthings/cl-provisioning`.

# Dev

Load the .asd, quickload it then

```
CL-USER> (cl-provisioning/web:start-app)
```

See also:

- `web::load-config &key port load-init-p`


## Tests

Tests are defined with [Fiveam](https://common-lisp.net/project/fiveam/docs/).

Run them from the terminal with `make test`. You should see a failing test.

```bash
$ make test
Running test suite TESTMAIN
 Running test TEST1 f
 Did 1 check.
    Pass: 0 ( 0%)
    Skip: 0 ( 0%)
    Fail: 1 (100%)

 Failure Details:
 --------------------------------
 TEST1 in TESTMAIN []:

3

 evaluated to

3

 which is not

=

 to

2

Makefile:15: recipe for target 'test' failed

$ echo $?
2
```

On Slime, load the test package and run `run!`.

---

Licence: BSD
