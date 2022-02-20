#!/bin/bash
curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx /tmp
install -ma+x /tmp/kubectx /usr/local/bin/kubectx
curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens /tmp
install -ma+x /tmp/kubecns /usr/local/bin/kubens
echo "source <(kubectl completion bash)" >> ~/.bashrc 
echo "source <(kubectl completion bash)" >> ~/.bashrc 
echo "alias k=kubectl" >> ~/.bashrc
echo "complete -F __start_kubectl k" >> ~/.bashrc
echo "Execute this: source ~/.bashrc"
