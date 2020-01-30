# Wingpanel Monitor

[![Build Status](https://travis-ci.org/PlugaruT/wingpanel-monitor.svg?branch=master)](https://travis-ci.org/PlugaruT/wingpanel-monitor)

<p align="center">
  <a href="https://appcenter.elementary.io/com.github.plugarut.wingpanel-monitor"><img src="https://appcenter.elementary.io/badge.svg" alt="Get it on AppCenter" /></a>
</p>


![Screenshot](data/screenshot_1.png)
![Screenshot](data/screenshot_2.png)


## Building and Installation

You'll need the following dependencies:

```
libglib2.0-dev
libgtop2-dev
libgranite-dev
libgtk-3-dev
libwingpanel-2.0-dev
meson
valac
```

You can install them running
```
sudo apt install libgtop2-dev libgranite-dev libgtk-3-dev libwingpanel-2.0-dev meson valac
```

Run `meson` to configure the build environment and then `ninja` to build

```
meson build --prefix=/usr
cd build
ninja
```

To install, use `ninja install`

```
ninja install
```