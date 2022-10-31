## PostUp/PostDown Sample Configuration
### PostUp
1. If you want to address translate an access coming to port 80 to 192.168.11.2 in your LAN, you would register the following command.

    ```sh
    iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.11.2:80
    ```

1. Similarly, to address translate an access coming to port 8888 to 192.168.11.3 in the LAN, you would register the following command.

    ```sh
    iptables -t nat -A PREROUTING -p tcp --dport 8888 -j DNAT --to-destination 192.168.11.3:8888
    ```

1. Next, setup IP masquerade.

    ```sh
    iptables -t nat -A POSTROUTING -d 192.168.11.0/24 -j MASQUERADE
    ```

1. Finally, save the above command in `conf.up.d/01-routing-lan-access.conf`. In other words, save the following command to `conf.up.d/01-routing-lan-access.conf`.

    ```sh
    iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.11.2:80
    iptables -t nat -A PREROUTING -p tcp --dport 8888 -j DNAT --to-destination 192.168.11.3:8888
    iptables -t nat -A POSTROUTING -d 192.168.11.0/24 -j MASQUERADE
    ```

### PostDown
Save the following command in `conf.down.d/01-routing-lan-access.conf`.

```sh
iptables -t nat -D PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.11.2:80
iptables -t nat -D PREROUTING -p tcp --dport 8888 -j DNAT --to-destination 192.168.11.3:8888
iptables -t nat -D POSTROUTING -d 192.168.11.0/24 -j MASQUERADE
```
