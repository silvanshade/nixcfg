#!/usr/bin/env bash

# USB 3.1 Only
for port in $(lspci | grep xHCI | cut -d' ' -f1); do
  echo -n "0000:${port}" | sudo tee /sys/bus/pci/drivers/xhci_hcd/unbind
  echo -n "0000:${port}" | sudo tee /sys/bus/pci/drivers/xhci_hcd/bind
done

# All USB
for port in $(lspci | grep USB | cut -d' ' -f1); do
  echo -n "0000:${port}" | sudo tee /sys/bus/pci/drivers/xhci_hcd/unbind
  echo -n "0000:${port}" | sudo tee /sys/bus/pci/drivers/xhci_hcd/bind
done

uhubctl --exact --vendor 2188:0031 --ports 1-8 --action on
