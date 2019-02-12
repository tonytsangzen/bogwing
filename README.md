# bogwing
A emulator for yodaOS
![Image text](https://raw.githubusercontent.com/tonytsangzen/bogwing/master/bogwing.jpg)
### 1. HOW TO
#### MacOS
```Bash
brew install qemu
git clone https://github.com/tonytsangzen/bogwing.git
cd bogwing
./run.sh raspberry
```
#### Ubuntu
```Bash
sudo apt-get -y install libcurl3 libpixman-1-0 libnuma1 libglib2.0-0 
git clone https://github.com/tonytsangzen/bogwing.git
cd bogwin
./run.sh raspberry
```
#### Docker
```Bash
docker pull  tonytsangzen/bogwing-docker:latest
docker run -it --name bogwing  tonytsangzen/bogwing-docker  /bogwing/run.sh raspberry
```

#### [Link to yodaOS](https://github.com/yodaos-project/yodaos)
