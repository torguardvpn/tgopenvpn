# TorGuard OpenVPN OpenWRT App  

## 🌍 Overview  
The **TorGuard OpenVPN OpenWRT App** makes it simple to connect to **TorGuard's OpenVPN servers** on OpenWRT. With an easy-to-use interface, you can choose from a **full server list**, enable **Dedicated IP support**, and customize **VPN protocol, port, and cipher options**.  

### 🆕 **Latest Features & Updates**  
✅ **Full TorGuard OpenVPN Server List** – Easily select and switch between VPN locations.  
✅ **Enable/Disable VPN Option** – Start or stop OpenVPN with a single toggle.  
✅ **Dedicated IP Support** – Connect seamlessly with your **TorGuard Dedicated IP**.  
✅ **Custom VPN Protocols, Ports, & Ciphers** – Fine-tune your OpenVPN connection settings.  
✅ **Connection Status Display** – View whether your VPN is **connected or disconnected**.  
✅ **RX/TX Traffic Info** – Monitor real-time **upload and download speeds**.  

This app is **officially maintained by TorGuard** to provide a seamless OpenVPN experience on OpenWRT.  

---

## 📥 Installation Methods  

### 🏗️ **Compile from Source using OpenWRT SDK**  

To build the package from source using the OpenWRT SDK, follow these steps:  

1️⃣ **Navigate to the OpenWRT SDK Directory**  
```bash
cd ~/openwrt/package
```
*(Ensure you have the OpenWRT SDK set up beforehand.)*  

2️⃣ **Clone the TorGuard OpenVPN App Repository**  
```bash
git clone https://github.com/TorGuard/tgopenvpn.git
```

3️⃣ **Compile the Package**  
```bash
cd ~/openwrt
make package/tgopenvpn/compile V=s
```

4️⃣ **Locate the Compiled `.ipk` File**  
After compilation, the package will be found in:  
```
~/openwrt/bin/packages/<target_architecture>/base/tgopenvpn.ipk
```
*(Replace `<target_architecture>` with your OpenWRT device's architecture.)*  

---

### 📦 **Install Precompiled `.ipk` Package**  

#### 🖥️ **Method 1: Install via OpenWRT Web UI**  
1️⃣ **Download the `.ipk` file** from the [GitHub Releases](https://github.com/TorGuard/tgopenvpn/releases).  
2️⃣ **Log into OpenWRT's Web Interface**.  
3️⃣ Navigate to **System ⚙️ → Software**.  
4️⃣ Click **Upload Package**, select the `.ipk` file, and click **Install**.  

---

#### ⏬ **Method 2: Install via `wget` (SSH)**  
1️⃣ **SSH into your OpenWRT Router**  
```bash
ssh root@192.168.1.1
```

2️⃣ **Download and Install the Package**  
```bash
cd /tmp
wget https://github.com/TorGuard/tgopenvpn/releases/latest/download/tgopenvpn.ipk
opkg install tgopenvpn.ipk
```

---

## 🚀 **Usage**  

1️⃣ Open the **TorGuard OpenVPN App** in OpenWRT.  
2️⃣ Select your **preferred server** from the list.  
3️⃣ Choose your **protocol, port, and cipher settings**.  
4️⃣ **(Optional) Enable Dedicated IP** if you have one.  
5️⃣ Click **Connect** to establish the VPN tunnel.  
6️⃣ Check **Connection Status** and **RX/TX Traffic Info** for real-time monitoring.  

---

## 🔗 **Support & Updates**  
This OpenWRT app is **officially maintained by TorGuard**.  
📞 **Support:** [TorGuard Support](https://torguard.net/)  
📢 **Latest Releases:** [GitHub Releases](https://github.com/TorGuard/tgopenvpn/releases)  

---

**Enjoy a secure and private OpenVPN connection on OpenWRT with TorGuard!** 🚀🔒  
