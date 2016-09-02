# odd

Odd is a peculiar little software renderer written in Haxe that aims to be platform agnostic.

The idea is to define the rendering process in a cross-platform way, and have it accessible to platform-specific rendering contexts.

**Please note that Odd is still under development!**

| Platform | Target         | Repository                                                            | 
| -------- | -------------- | --------------------------------------------------------------------- |
| Desktop  | Java (Swing)   | [odd-target-java](https://github.com/dstrekelj/odd-target-java)       |
| Mobile   | Android        | [odd-target-android](https://github.com/dstrekelj/odd-target-android) |
| Web      | HTML5 (Canvas) | [odd-target-html5](https://github.com/dstrekelj/odd-target-html5)     |

For examples of use, please visit the [odd-samples](https://github.com/dstrekelj/odd-samples) repository.

## Instructions

1. Get [Haxe](http://haxe.org/download/). Odd was developed with 3.3.0-rc1, but any 3.2.x version is likely to work as well.
2. Get odd: `haxelib git odd https://github.com/dstrekelj/odd.git`.
3. Get one (or several!) Odd targets from `odd-target-*` repositories.
4. Try the samples in the `odd-samples` repository.

## Documentation

I have tried to keep the sources well documented, but not everything can fit into a couple of comment lines.

Please refer to the repository wiki for more complete documentation.