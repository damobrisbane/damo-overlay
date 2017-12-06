![](/images/gentoo-logo.png)

Gentoo custom overlay, QA'd so please let me know if ebuilds herein do not work for you.

[Nov 10, 2017]

**fabio** ebuild with dependencies, *govendor* and *vendorfmt*

Shown here out-of-the box install tcp-proxying [Syncthing](https://syncthing.net)

![Fabio](/images/fabio1.png)

Example Emerge
--------------

//..> emerge -aq fabio
```
[ebuild  N    ] dev-go/govendor-1.0.9
[ebuild  N    ] dev-go/vendorfmt-9999
[ebuild  N    ] net-proxy/fabio-1.5.3*
```

Would you like to merge these packages? [Yes/No] y
```
>>> Verifying ebuild manifests
>>> Emerging (1 of 3) dev-go/govendor-1.0.9::damo-overlay
>>> Installing (1 of 3) dev-go/govendor-1.0.9::damo-overlay
>>> Emerging (2 of 3) dev-go/vendorfmt-9999::damo-overlay
>>> Installing (2 of 3) dev-go/vendorfmt-9999::damo-overlay
>>> Emerging (3 of 3) net-proxy/fabio-1.5.3::damo-overlay
>>> Installing (3 of 3) net-proxy/fabio-1.5.3::damo-overlay
>>> Recording net-proxy/fabio in "world" favorites file...*
```
//..>

Example Run
-------------

//..> /etc/init.d/fabio restart 
```
* Stopping fabio ... [ ok ]
* Starting fabio ... [ ok ]
```

//..> tail /var/log/fabio/fabio.log
```
2017/11/10 11:24:04 [INFO] TCP proxy listening on :8384
2017/11/10 11:24:04 [INFO] consul: Health changed to #1111111
2017/11/10 11:24:04 [INFO] consul: Registered fabio with id "fabio-host1-9998"
2017/11/10 11:24:04 [INFO] consul: Registered fabio with address "192.168.1.1"
2017/11/10 11:24:04 [INFO] consul: Registered fabio with tags ""
2017/11/10 11:24:04 [INFO] consul: Registered fabio with health check to "http://[192.168.1.1]:9998/health"
2017/11/10 11:24:04 [INFO] Config updates
+ route add syncthing :8384 tcp://192.168.1.1:8384 tags "syncthing"
2017/11/10 11:24:04 [INFO] consul: Health changed to #1111111
2017/11/10 11:24:05 [INFO] consul: Health changed to #1111111*
```
//..>


