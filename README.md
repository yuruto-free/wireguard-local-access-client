# WireGuard client for local access

## Preparation
1. Copy a peer configuration file from your WireGuard server.
1. Set the configuration file to `./config/wg0.conf`.
1. Add the following configuration in Interface section to `./config/wg0.conf`. See [the sample.wg0](./sample.wg0) for details.

    ```sh
    PostUp = /config/iptables_script/postup.sh
    PostUp = iptables -t nat -A POSTROUTING -d 192.168.0.0/24 -j MASQUERADE
    PostDown = /config/iptables_script/postdown.sh
    PostDown = iptables -t nat -D POSTROUTING -d 192.168.0.0/24 -j MASQUERADE
    ```

1. Update `PUID` and `PGID` in `docker-compose.yml`. These IDs can be obtained by executing the following command.

    ```sh
    id ${USER}
    # output example
    # uid=1000(yuruto) gid=1000(yuruto) groups=1000(yuruto)
    # PUID = 1000 (= uid), PGID = 1000 (= gid)
    ```

1. Give the current user execute permissions.

    ```sh
    # for wrapper.sh
    chmod +x wrapper.sh

    # for postup.sh and postdown.sh in config/iptables_script
    pushd config/iptables_script
    chmod +x postup.sh postdown.sh
    popd
    ```

1. Create several scripts for address translation. See [the README.md](./config/iptables_script/README.md) for details.

## Start
Enter the following command to start the container.

```sh
./wrapper.sh start
```

## Stop/Down
Run the following command.

```sh
# stop
./wrapper.sh stop

# down
./wrapper.sh down
```

## Check status/log
Execute the following command.

```sh
# show process status
./wrapper.sh ps
docker-compose ps

# show log
./wrapper.sh logs
```

## FAQ
If the container does not start on your Raspberry Pi, access to the [libseccomp](https://ftp.debian.org/debian/pool/main/libs/libseccomp/) and install the following library.

```sh
# ========
# Examples
# ========
# armhf/armv7l
wget https://ftp.debian.org/debian/pool/main/libs/libseccomp/libseccomp2_2.5.4-1+b1_armhf.deb
sudo dpkg -i libseccomp2_2.5.4-1+b1_armhf.deb

# arm64/aarch64
wget https://ftp.debian.org/debian/pool/main/libs/libseccomp/libseccomp2_2.5.4-1+b1_arm64.deb
sudo dpkg -i libseccomp2_2.5.4-1+b1_arm64.deb
```

The following commands can be used to find out whether you fall under the `armhf/armv7l` or `arm64/aarch64` category.

```sh
uname -m
```
