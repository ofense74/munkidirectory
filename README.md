#Description
**AD Munki** is a set of tools for installing applications with Munki based on Active Directory group membership.

It contains a client version that checks which Active Directory groups the client is a member of.

It also contains a "Server" version for setting up the rules for what should be installed on clients that are members of a certain Active Directory group.

The **Munki** project is housed here:
<http://code.google.com/p/munki/>

The executables can be downloaded here:
<https://s3-eu-west-1.amazonaws.com/admunki/ADMunki.dmg>

##Version 1.2 build 1
The client will now look for a case insensitive version of itself in the AD. The AD plugin on the mac makes itself lower-case whether you like it or not. It sometimes communicates this to the AD and thus it changes there too. This should fix issues with that.

The server version now asks you if you want to save before quitting. If you don't it will revert to the last saved state when you start the app again.

##Version 1.1 build 3
Fixed a bug in AD Munki Server that would appear when dragging from the Application or Manifest view after sorting it.

##Version 1.1 build 1
Added drag and drop functionality for applications and manifests. Just click the "Application" and "Manifests" buttons in the upper right corner.

Possibility for adding the AD-functionality to manifests. Choose "AD Manifests" under the "Tools" Menu.

##Version 1.01
Fixed user interface.