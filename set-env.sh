#!/bin/bash
curl -sLO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
install -ma+x kubectx /usr/local/bin/kubectx
curl -sLO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
install -ma+x kubens /usr/local/bin/kubens
rm kubectx kubens
echo "source <(kubectl completion bash)" >> ~/.bashrc 
echo "source <(kubectl completion bash)" >> ~/.bashrc 
echo "alias k=kubectl" >> ~/.bashrc
echo "complete -F __start_kubectl k" >> ~/.bashrc
echo "Execute this: source ~/.bashrc"
