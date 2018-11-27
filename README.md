container-pupil
===============

Linux container for the [Pupil](https://pupil-labs.com/) eye tracking software.

A container provides several benefits:
- The installation steps are described in a Git repository, with the history,
  be able to create branches, come back to an earlier version, and all the
  other benefits of using Git.
- The installation is automated and is always “clean”. Outside a container, if
  you install and then uninstall a bunch of packages, tweak the configuration
  files, etc, it can be hard to know exactly why the software works or doesn't
  work. With a container, the build is reproducible.
- Once the software works well in the container, there are more guarantees that
  it will still work in the future, since the state of the container can be
  reset each time the container is run. On a traditional OS, your software may
  work thanks to some state of the system. Here everything is described in Git.
- The container can run on different Linux distributions.
- What is installed in production will be as similar as possible to what the
  developers have tested.

More information:
- [Pupil](https://pupil-labs.com/)
- [Podman](https://podman.io/)

Build the container image
-------------------------

As root:
```
# ./build.sh
```

Run the container
-----------------

As root:
```
# ./run.sh
```

or

```
# ./run.sh /path/where/recordings/should/be/saved
```
