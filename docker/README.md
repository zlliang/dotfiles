# Docker Practices

I use [Docker](https://docker.com) containers as my development enviroments, thanks to VS Code's [remote development feature for containers](https://code.visualstudio.com/docs/remote/containers). This directory contains several image building files to build Docker images for development. These images can be found on the [Docker Hub](https://hub.docker.com) repository [`zllliang/dev`](https://hub.docker.com/r/zlliang/dev/).

- `zlliang/dev:base`: Basic image built from `debian:sid`. Fish shell, exa, bat, ripgrep and fd-find are installed.
- `zlliang/dev:gcc`: C/C++ development environment built from `base`. GCC and CMake are installed.

## Story: Why I use Docker for development?

These days, I start learning the book [_CS:APP_](http://csapp.cs.cmu.edu) and try to do the labs written in C. There are several binary files only can run on Linux systems, but I am using macOS. I tried to rent a virtual machine from [Aliyun](https://aliyun.com) and developing under SSH connections, but the experience is not good. Then I find Docker and VS Code's remote development feature for containers, and I am attracted! Docker lets you to create an isolated Linux environment, a sandbox, to work on and to experiment, without messing your host environment up. 

In fact, as the [VS Code blog](https://code.visualstudio.com/blogs/2019/05/02/remote-development) says, containers make great development environments because:

> - You can develop with a consistent and easily reproducible tool chain, on the same operating system you are deploying to;
> - Containers are isolated, meaning you can quickly swap between different development environments without impacting your local machine;
> - It easy for others to contribute to your project as they can easily develop, build, and test in a consistent development environment.

So I decide to use Docker containers as my development environments.
