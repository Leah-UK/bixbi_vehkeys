<h1 align='center'><a href='https://discord.gg/sBfSsEjgMT'>Discord</a></h1>
<p align='center'><a href='https://forum.cfx.re/u/Leah_UK/summary'>FiveM Profile</a> | <a href='https://ko-fi.com/bixbi'>Support Me Here</a><br></p>

---

<h2 align='center'>Information</h2>

A very basic vehicle locking system. By default players part of the ambulance or police job can open any <b>emergency</b> vehicle as if it was their own. You can change this in server.lua and within the '<b>bixbi_vehkeys:CheckKey</b>' event.

---

<h2 align='center'>Requirements</h2>

- <a href='https://github.com/overextended/es_extended'>"Ox" ESX</a>,<i> You can modify for other frameworks. <b>Please make a PR if you do</b></i>
- <a href='https://github.com/Leah-UK/bixbi_core'>bixbi_core</a>
- <a href='https://github.com/zf-development/zf_dialog'>zf_dialog</a>

---

<h2 align='center'>Exports</h2>
<i>You will need to use the following exports when a vehicle is spawned, to give them the correct key</i>
</br>
</br>
<b>Give Player a Key - Server Only</b>
<code>TriggerEvent('bixbi_vehkeys:AddKey', playerId, plate)</code>
Example:<code>TriggerEvent('bixbi_collection:AddKey', 1, "LE4H")</code>

<b>Remove Key from Player - Server Only</b>
<code>TriggerEvent('bixbi_vehkeys:RemoveKey', playerId, plate)</code>
Example:<code>TriggerEvent('bixbi_vehkeys:RemoveKey', 1, "LE4H")</code>

---
<p align='center'><i>Feel free to modify to your liking. Please keep my name <b>(Leah#0001)</b> in the credits of the fxmanifest. <b>If your modification is a bug-fix I ask that you make a pull request, this is a free script; please contribute when you can.</b></i></p>
