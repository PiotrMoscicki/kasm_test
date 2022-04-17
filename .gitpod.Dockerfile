FROM gitpod/workspace-full

# update and install required prerequisities
RUN sudo apt-get -y update
RUN sudo apt-get install -y apt-utils

# download KasmVNC release and install it
RUN wget https://github.com/kasmtech/KasmVNC/releases/download/v0.9.2-beta/kasmvncserver_ubuntu_focal_0.9.2_amd64.deb

RUN sudo apt-get -y install ./kasmvncserver_*.deb

# We provide an example script to run KasmVNC at #
# /usr/share/doc/kasmvncserver/examples/kasmvncserver-easy-start. It runs a VNC
# server on display :10 and on interface 0.0.0.0. If you're happy with those
# defaults you can just use it as is:
RUN sudo ln -s /usr/share/doc/kasmvncserver/examples/kasmvncserver-easy-start /usr/bin/

# Add your user to the ssl-cert group
RUN sudo addgroup $USER ssl-cert
# You will need to re-connect in order to pick up the group change

# Create ~/.vnc directory and corresponding files.
RUN kasmvncserver-easy-start -d && kasmvncserver-easy-start -kill

# Modify vncstartup to launch your environment of choice, in this example LXDE
# This may be optional depending on your system configuration
RUN echo '/usr/bin/lxsession -s LXDE &' >> ~/.vnc/xstartup

# Start KasmVNC with debug logging:
#RUN kasmvncserver-easy-start -d

# Tail the logs
#RUN tail -f ~/.vnc/`hostname`:10.log