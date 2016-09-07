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

1. Get [Haxe](http://haxe.org/download/).

    * 3.3.0-rc1 was used to develop Odd
    * 3.2.x was tested and worked for HTML5, but the generated Java code was sometimes slow on Java, Android targets

2. Get Odd.

    * For git users: `haxelib git odd https://github.com/dstrekelj/odd.git`
    * Everyone else: `haxelib dev odd path/to/downloaded/odd/repository`

3. Get one (or several!) Odd targets from `odd-target-*` repositories.

4. Try the samples in the `odd-samples` repository.
