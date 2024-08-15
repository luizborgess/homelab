ansible all -m ping -u root --ask-pass
ansible-playbook test.yml -u root --ask-pass


ansible-galaxy role install ajsalminen.hosts

# Homelab


## Portainer

## Kubernetes

## Workstation

Run

```
ansible-playbook workstation/local.yml
```
After run, restart computer.
