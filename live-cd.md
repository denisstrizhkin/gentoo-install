Set root password

```bash
passwd root
```

Change sshd settings `PasswordAuthentication yes`

```bash
vi /etc/ssh/sshd_config
```

Start ssh

```bash
/etc/init.d/sshd start
```

Check ip

```bash
ip a
```