module("luci.controller.admin.tgopenvpn", package.seeall)
function index()
	entry({"admin", "vpn", "tgopenvpn"}, cbi("torguard/tgopenvpn"), _("TorGuard OpenVPN"), 102)
end