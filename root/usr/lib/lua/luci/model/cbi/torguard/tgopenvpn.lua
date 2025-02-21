-- Import the necessary LuCI modules
local uci = require("luci.model.uci").cursor()
local sys = require("luci.sys")
local util = require("luci.util")

-- Function to check if OpenVPN (tun0) is active
local function is_vpn_connected()
    local status = sys.call("ip link show tun0 >/dev/null 2>&1")
    return (status == 0) and "Connected" or "Disconnected"
end

-- Function to get RX and TX statistics for tun0
local function get_vpn_traffic()
    local rx, tx = "N/A", "N/A"
    local f = io.popen("ifconfig tun0 | grep 'RX bytes' 2>/dev/null")
    if f then
        local output = f:read("*a")
        f:close()
        if output then
            rx = output:match("RX bytes:(%d+)") or "N/A"
            tx = output:match("TX bytes:(%d+)") or "N/A"
        end
    end
    return rx, tx
end

-- Define the model
m = Map("tgopenvpn_cfg", "TorGuard OpenVPN Setup")

-- VPN Status Section
status_section = m:section(TypedSection, "ovpnconfig", "OpenVPN Status")
status_section.anonymous = true
status_section.addremove = false

status = status_section:option(DummyValue, "_vpn_status", translate("VPN Status"))
status.value = is_vpn_connected()

-- VPN Traffic Stats
rx, tx = get_vpn_traffic()
rx_stat = status_section:option(DummyValue, "_vpn_rx", translate("RX Bytes"))
rx_stat.value = rx .. " Bytes"

tx_stat = status_section:option(DummyValue, "_vpn_tx", translate("TX Bytes"))
tx_stat.value = tx .. " Bytes"

-- Define the section for the OpenVPN settings
s = m:section(TypedSection, "ovpnconfig", "OpenVPN Settings")
s.anonymous = true
s.addremove = false

-- Define the input fields for the OpenVPN settings
user = s:option(Value, "username", translate("VPN Username"))
pass = s:option(Value, "password", translate("VPN Password"))
pass.password = true


-- Enable Ovpn Option
enabled_option = s:option(ListValue, "status", "Enable OpenVPN")
enabled_option:value("yes", "Yes")
enabled_option:value("no", "No")
enabled_option.default = "no"
enabled_option.optional = false
enabled_option.rmempty = false

svr = s:option(ListValue, "server", translate("VPN Server"))
-- Add all servers here
svr:value("ar.torguard.com", "Argentina")
svr:value("au.torguard.com", "Australia Sydney")
svr:value("aus.torguard.com", "Austria")
svr:value("bg.torguard.com", "Belgium")
svr:value("br.torguard.com", "Brazil 1")
svr:value("br2.torguard.com", "Brazil 2")
svr:value("bul.torguard.com", "Bulgaria")
svr:value("ca.torguard.com", "Canada Toronto")
svr:value("cavan.torguard.com", "Canada Vancouver")
svr:value("ch.torguard.com", "Chile")
svr:value("cz.torguard.com", "Czech Republic")
svr:value("dn.torguard.com", "Denmark")
svr:value("fn.torguard.com", "Finland")
svr:value("fr.torguard.com", "France")
svr:value("ger.torguard.com", "Germany")
svr:value("gre.torguard.com", "Greece")
svr:value("hk.torguard.com", "Hong Kong")
svr:value("hg.torguard.com", "Hungary")
svr:value("ice.torguard.com", "Iceland")
svr:value("in.torguard.com", "India Mumbai")
svr:value("ire.torguard.com", "Ireland")
svr:value("isr-loc1.torguard.com", "Israel Tel Aviv")
svr:value("it.torguard.com", "Italy")
svr:value("id.torguard.com", "Indonesia")
svr:value("jp.torguard.com", "Japan")
svr:value("lux.torguard.com", "Luxembourg")
svr:value("mx.torguard.com", "Mexico")
svr:value("md.torguard.com", "Moldova")
svr:value("nl.torguard.com", "Netherlands")
svr:value("nz.torguard.com", "New Zealand")
svr:value("no.torguard.com", "Norway")
svr:value("pl.torguard.com", "Poland")
svr:value("pg.torguard.com", "Portugal")
svr:value("ro.torguard.com", "Romania")
svr:value("ru.torguard.com", "Russia")
svr:value("sg.torguard.com", "Singapore")
svr:value("slk.torguard.com", "Slovakia")
svr:value("sp.torguard.com", "Spain")
svr:value("sk.torguard.com", "South Korea")
svr:value("sa.torguard.com", "South Africa")
svr:value("swe.torguard.com", "Sweden")
svr:value("swiss.torguard.com", "Switzerland")
svr:value("tw.torguard.com", "Taiwan")
svr:value("th.torguard.com", "Thailand")
svr:value("tk.torguard.com", "Turkey")
svr:value("uae.torguard.com", "UAE")
svr:value("uk.torguard.com", "UK London")
svr:value("uk.man.torguard.com", "UK Manchester")
svr:value("ukr.torguard.com", "Ukraine")
svr:value("us-fl.torguard.com", "USA Miami")
svr:value("us-atl.torguard.com", "USA Atlanta")
svr:value("us-ny.torguard.com", "USA New York")
svr:value("us-chi.torguard.com", "USA Chicago")

dedicated = s:option(ListValue, "dedicated", translate("Use Dedicated IP"))
dedicated:value("YES")
dedicated:value("NO")

dediserver = s:option(Value, "dediserver", translate("Dedicated IP"))

protocol = s:option(ListValue, "protocol", translate("VPN Protocol"))
protocol:value("udp")
protocol:value("tcp")

port = s:option(ListValue, "port", translate("VPN Port"))
-- Add all ports here
port:value("1912|SHA256", "1912|SHA256")
port:value("1195|SHA256", "1195|SHA256")
port:value("53|SHA256", "53|SHA256")
port:value("1198|SHA256", "1198|SHA256")
port:value("9201|SHA256", "9201|SHA256")
port:value("501|SHA256", "501|SHA256")
port:value("1194|SHA1", "1194|SHA1")
port:value("995|SHA1", "995|SHA1")
port:value("1215|SHA512", "1215|SHA512")
port:value("389|SHA512", "389|SHA512")
port:value("80|SHA1", "80|SHA1")
port:value("443|SHA1", "443|SHA1")

cipher = s:option(ListValue, "cipher", translate("VPN Cipher"))
-- Add all cipher options here
cipher:value("AES-128-CBC")
cipher:value("AES-256-CBC")
cipher:value("AES-128-GCM")
cipher:value("AES-256-GCM")
cipher:value("BF-CBC")

-- VPN Control: Start/Stop OpenVPN
ctrl = m:section(TypedSection, "ovpnconfig", "VPN Control: Start/Stop OpenVPN")
ctrl.anonymous = true
ctrl.addremove = false

btnStop = ctrl:option(Button, "_btn_start", translate("Click to Stop OpenVPN"))
function btnStop.write()
    io.popen("/etc/init.d/tgopenvpn stop")
end

btnStart = ctrl:option(Button, "_btn_stop", translate("Click to Start OpenVPN"))
function btnStart.write()
    io.popen("/etc/init.d/tgopenvpn start")
end

-- Return the configuration page
return m
