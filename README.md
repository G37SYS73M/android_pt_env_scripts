# Android Pentest Enviorment Scripts
- By G37SYS73M
## To Build 

```bash

docker build -t android-pentest-env .

```

## 🖥️ Run with X11 Forwarding (on Linux host)

```bash

xhost +local:docker

docker run -it --rm \
  --net=host \
  --env DISPLAY=$DISPLAY \
  --env QT_X11_NO_MITSHM=1 \
  --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --privileged \
  --name android_gui \
  android-pentest-env

```

- Once inside:

```bash

jadx-gui

```

## 🖥️ Alternative: Run with VNC (for macOS/Windows)
Inside the container:

```bash


vncserver :1
Then connect to localhost:5901 with your favorite VNC viewer (password setup will prompt on first run).
```

- To auto-start XFCE in VNC:

```bash
echo "startxfce4 &" > ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup
```
