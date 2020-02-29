# Kevin and Maisey

## Installation
- install haxe, lime, haxeflixel
- install http-server globally via npm

## Run game locally
In one tab run:
```sh
watchman-make -p 'source/*.hx' 'assets/data/*.tmx' -r 'sh watcher.sh'
```

In the other:
```sh
http-server export/html5/bin
```