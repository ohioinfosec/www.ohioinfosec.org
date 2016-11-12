---
layout: post
navbar: Blog
title: "Meeting Notes - November 10th, 2016"
date: 2016-11-10 20:00:00 -0400
comments: true
categories: Notes
---

When shopping on Amazon this holiday season, make sure to use [our Amazon
Smile](https://smile.amazon.com/ch/26-1330537) link. It doesn't cost you
anything extra and a portion of the price goes to OISF. It's a simple way to
keep us running.

### Discussion Stories

* [Use this Amazon Smile link to support OISF](https://smile.amazon.com/ch/26-1330537)
    * This won't cost you anything or make your purchases more expensive, this takes money from Amazon and gives it to us.
* [Charles Monett's IP Camera Firmware Scripts](https://github.com/cm-code/firmware-scripts)
    * Scripts used in this month's presentation!
* [Politico's Morning Cyber Security Briefing](http://www.politico.com/tipsheets/morning-cybersecurity)
    * A daily dose of infosec policy and news
* [Mirai Malware](https://en.wikipedia.org/wiki/Mirai_(malware)) - Malware that has been terrorizing the internet via DDOS attacks
    * [The 61 passwords used to spread Mirai](http://www.csoonline.com/article/3126924/security/here-are-the-61-passwords-that-powered-the-mirai-iot-botnet.html)
    * [Mirai takes down Dyn, impacting Twitter, Spotify, Reddit, Netflix, and more](https://krebsonsecurity.com/2016/10/ddos-on-dyn-impacts-twitter-spotify-reddit/)
        * Attack strength can reach 1 Tbps
    * [Mirai tries to take Liberia offline](https://krebsonsecurity.com/2016/11/did-the-mirai-botnet-really-take-liberia-offline/)
    * [Mirai Source Code Released](https://github.com/jgamblin/Mirai-Source-Code)
* [Patch your Linux kernels! Dirty COW vulnerability announced and patched.](https://dirtycow.ninja/)
* [Google discloses Windows zero-day before Microsoft releases patch](http://www.bleepingcomputer.com/news/security/google-discloses-windows-zero-day-before-microsoft-can-issue-patch/)

### CubeSat Secure Communication Notes

We had a very interesting discussion on how to secure [CubeSat](https://en.wikipedia.org/wiki/CubeSat) communications, here are those notes:

* Limitations:
    * System limitations
        * 16Mhz Processor
        * 512 kb flash storage (~256 kb workable)
        * 80 kb RAM (unknown workable amount)
        * ~800 bits per second transfer rate
            * Only works when you can see the CubeSat
            * Uses a 16-byte command string
        * Most programming done in C
        * Runs [freeRTOS](http://www.freertos.org/)
    * Needs something that will survive a VERY harsh environment
        * Radiation can randomly reset the system, corrupt memory, etc
    * Unknown transfer error rate
    * No guarantees on transfer delivery (think UDP)

* Good things:
    * An attacker breaching the system has little real consequence
        * The attacker could restart the device
        * The attacker could stop commands in progress or issue commands that the CubeSat doesn't need
        * The attacker cannot reprogram the device (firmware is set)
        * The attacker could break international radio regulations
            * This has no real effect on anyone
        * The attack could be annoying, but cannot cause damage

* Thoughts on securing the communications channel:
    * Encryption:
        * [Diffie–Hellman key exchange
](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange)
        * [One-time pad](https://en.wikipedia.org/wiki/One-time_pad) (based on time window)
            * Size is limited on the device
        * [Shared Secret (pre-shared key)](https://en.wikipedia.org/wiki/Pre-shared_key)
        * [ED25519 Public Key Encryption](https://en.wikipedia.org/wiki/EdDSA)
            * It was decided that public-key crypto is far too big to transmit
        * [Double Ratchet Algorithm](https://en.wikipedia.org/wiki/Double_Ratchet_Algorithm)
            * Design to be self-healing
            * Doesn't require an always-on connection
            * Still probably too big to transmit...
    * Command signing?
    * DirectTV-style Memory Puzzle
        * Send the command as small pieces of useless memory and memory locations that a C program will put into a buffer
        * Once enough pieces have been send, the c program can re-arrage the resulting data into a legitimate command
        * Only the architect of the program knows the correct sequence and memory locations

* Other notes:
    * [WolfSSL could be helpful here](http://www.freertos.org/FreeRTOS-Plus/WolfSSL/WolfSSL.shtml)
    * [DNP3 could be used as a communication template](https://en.wikipedia.org/wiki/DNP3)
    * [Dynamic secrets could be helpful](https://en.wikipedia.org/wiki/Dynamic_secrets)

OISF lives on your donations. Shake down your boss: Become a donor today. OISF
is a 501c3 organization and donations are tax deductible. For more information,
email [info@ohioinfosec.org](mailto:info@ohioinfosec.org).
