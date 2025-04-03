I originally posted a similar answer here, but hopefully this clears things up:
NVIDIA/k8s-device-plugin#168 (comment)

The set of packages collectively referred to as nvidia-docker consists of the following components (and their dependencies from top to bottom):

nvidia-docker2
nvidia-container-runtime
nvidia-container-toolkit
libnvidia-container
Unfortunately, the documentation across the repos that host code for these projects is inconsistent and misleading at times.

Some places say that nvidia-docker2 should no longer be installed for docker versions 19.03+ because it is deprecated, and you should install nvidia-container-toolkit instead. Other places say that nvidia-docker2 is required (even for docker versions 19.03+) if you plan on running Kubernetes on top of docker.

While both statements are technically true, I can see why things might be a little confusing.

Starting from the bottom, below is a description of what each of these components is responsible for:

libnvidia-container:
This package does the heavy-lifting of making sure that a container is set up to run with NVIDIA GPU support. It is designed to be container-runtime agnostic and provides a well-defined API and a wrapper CLI that different runtimes can invoke to inject NVIDIA GPU support into their containers.

nvidia-container-toolkit:
This package includes a script that implements the interface required by a runC prestart hook. This script is invoked by runC after a container has been created, but before it has been started, and is given access to the config.json associated with the container (e.g. this config.json). It then takes information contained in the config.json and uses it to invoke the libnvidia-container CLI with an appropriate set of flags. One of the most important flags being which specific GPU devices should be injected into the container.

nvidia-container-runtime:
This package used to be a complete fork of runC with NVIDIA specific code injected into it. Nowadays, it is a thin wrapper around the native runC installed on your machine. All it does is take a runC spec as input, inject the nvidia-container-toolkit script as a prestart hook into it, and then call out to the native runC, passing it the modified runC spec with that hook set. It's important to note that this package is not necessarily specific to docker (but it is specific to runC).

nvidia-docker2:
This package is the only docker-specific package of any of them. It takes the script associated with the nvidia-container-runtime and installs it into docker's /etc/docker/daemon.json file for you. This then allows you to run (for example) docker run --runtime=nvidia ... to automatically add GPU support to your containers. It also installs a wrapper script around the native docker CLI called nvidia-docker which lets you invoke docker without needing to specify --runtime=nvidia every single time. It also lets you set an environment variable on the host (NV_GPU) to specify which GPUs should be injected into a container.

Given this hierarchy of components it's easy to see that if you only install nvidia-container-toolkit (which is recommended for Docker 19.03+), then you will not get nvidia-container-runtime installed as part of it, and thus --runtime=nvidia will not be available to you. This is OK for Docker 19.03+ because it calls directly out to nvidia-container-toolkit when you pass it the --gpus option instead of relying on the nvidia-container-runtime as a proxy.

However, if you want to use Kubernetes with Docker 19.03, you actually need to continue using nvidia-docker2 because Kubernetes doesn't support passing GPU information down to docker through the --gpus flag yet. It still relies on the nvidia-container-runtime to pass GPU information down the stack via a set of environment variables.

So you are basically running on the exact same stack as you would be whether you install nvidia-docker2 or nvidia-container-toolkit, except that nvidia-docker2 will install a thin runtime that can proxy GPU information down to nvidia-container-toolkit via environment variables instead of relying on the --gpus flag to have Docker do it directly.
