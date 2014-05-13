docker-znc
==========

This Dockerfile builds an image with the latest version of [ZNC](znc.in). The image features an Ubuntu 14.04 LTS base with ZNC installed from source.

Quick Start
-----------

To get started, first create your ZNC configuration using:

    docker run -it --name znc_makeconf oddrationale/docker-znc --makeconf

The first step will ask you `What port would you like ZNC to listen on? (1025 to 65535)`. Enter a port number within the range (e.g. 6667) and remember it for the next step. Refer to the [ZNC configuration guide](http://wiki.znc.in/Configuration) for details of the other configuration options.

To start ZNC, enter the following command, replacing the port number with the port you select from the first step:

    docker run -d -p 6667:6667 --volumes-from znc_makeconf oddrationale/docker-znc

Make sure you have the proper firewall rules to access the port. If you enabled the webadmin module, you should be able to open `<your_ip_address>:<port_number>` in your browser to check that it is working (if you selected to use SSL, then prefix the URL with `https://`).

Details
-------

This image is configured to use Docker [data volumes](http://docs.docker.io/en/latest/use/working_with_volumes/) to store the ZNC configuration files. This has the advantage of keeping the ZNC configuration files (which include your IRC username, networks, and a hash of your password) separate from the underlying containers and images. For advanced users, it also allows us to upgrade the base image and keep the same ZNC configuration files. The first command from the **Quick Start** creates the ZNC configuration and stores it in a data volume. The `--name` option just gives us a handy way of referencing the container. The second command references the data volume from the first container using the `--volumes-from` option. The parameter from the `--name` and `--volumes-from` options need to match.

Autostart with systemd
----------------------

Here's an example unit file for `docker-znc.service`:

    [Unit]
    Description=docker-znc service
    After=docker.service
    Requires=docker.service
    
    [Service]
    ExecStart=/usr/bin/docker run -p 6667:6667 --rm --volumes-from znc_makeconf oddrationale/docker-znc
    
    [Install]
    WantedBy=multi-user.target

Questions/Feedback
------------------

Hope you find this image helpful! Feel free to [reach out to me directly](https://plus.google.com/u/0/108867134306691129687/posts) if you have any questions or feedback. Thanks!
