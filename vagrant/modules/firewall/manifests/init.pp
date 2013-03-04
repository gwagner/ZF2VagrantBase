class firewall
{
    include iptables

    iptables::allow {
        'tcp/80': port => '80', protocol => 'tcp'
    }
}