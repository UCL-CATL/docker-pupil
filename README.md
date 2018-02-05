docker-pupil
============

Ubuntu Docker container for the [Pupil](https://pupil-labs.com/) eye tracking
software.

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
- The container can run on different Linux distros.
- What is installed in production will be as similar as possible to what the
  developers have tested.

The Dockerfile doesn't try to install the bare minimum dependencies. But it's
already a good basis to work with the Pupil platform with a container.

More information:
- [Pupil](https://pupil-labs.com/)
- [Docker](https://www.docker.com/)

Host configuration
------------------

See the `host-config` file.

Build the container image
-------------------------

    # ./build.sh

Run the container
-----------------

    # ./run.sh

or

    # ./run.sh /path/where/recordings/should/be/saved
