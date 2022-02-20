#!/bin/bash
curl -sLO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx /tmp/kubectx
install -ma+x /tmp/kubectx /usr/local/bin/kubectx
curl -sLO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens /tmp/kubens
install -ma+x /tmp/kubens /usr/local/bin/kubens
echo "source <(kubectl completion bash)" >> ~/.bashrc 
echo "source <(kubectl completion bash)" >> ~/.bashrc 
echo "alias k=kubectl" >> ~/.bashrc
echo "complete -F __start_kubectl k" >> ~/.bashrc
echo "Execute this: source ~/.bashrc"
