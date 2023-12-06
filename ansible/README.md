### How to use Bastion to reach private server using Ansible (For Reference)

```
[web]
172.200.6.136

[postgres]
10.0.2.4

[postgres:vars]
ansible_ssh_common_args="-o ProxyCommand=\"ssh -p 22 -W %h:%p saitama@172.200.6.136 -i ~/.ssh/assessment \""
```