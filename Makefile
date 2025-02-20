

include $(TOPDIR)/rules.mk


LUCI_TITLE:=LuCI support for TorGuard OpenVPN
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+openvpn-openssl

define Package/tgopenvpn/conffiles
/etc/config/tgopenvpn_cfg
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
