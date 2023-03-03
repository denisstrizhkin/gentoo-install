Set `root` password

```console
# passwd root
```

Change `sshd` settings `PasswordAuthentication yes`

```console
# vi /etc/ssh/sshd_config
```

Start `sshd`

```console
# /etc/init.d/sshd start
```

Check ip (then `ssh` into it)

```console
# ip a
```