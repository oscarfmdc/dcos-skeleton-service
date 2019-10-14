# DCOS Skeleton minimal service

<a name="build-instructions"></a>
# Build Instructions

Since this framework was migrated from a branch off dcos-commons, you'll need a copy of that repository to build it
(until the build scripts are modified appropriately). Steps to build:

1. Clone [dcos-commons](https://github.com/mesosphere/dcos-commons).
2. Add the following two lines to `dcos-commons/settings.gradle`:

```
include 'frameworks/dcos-skeleton-service'
project(":frameworks/dcos-skeleton-service").name = "skeleton"
```

3. Add the following line to `dcos-commons/gradle/checkstyle/suppressions.xml`:

```
<suppress files="[\\/]dcos-skeleton-service[\\/]" checks="[a-zA-Z0-9]*"/>
```
4. Clone this repo into `dcos-commons/frameworks/`.
5. Use `dcos-commons/frameworks/dcos-skeleton-service/build.sh` to build.

<a name="publishing-instructions"></a>
# Publishing Instructions

```
export HTTP_HOST=x.x.x.x(your ip)
export HTTP_PORT=8080
./build.sh local
dcos package repo add --index=0 skeleton-local http://x.x.x.x:x/stub-universe-skeleton.json

```

To kill app via dcos cli

```
dcos marathon app list
dcos marathon app remove /skeleton
```