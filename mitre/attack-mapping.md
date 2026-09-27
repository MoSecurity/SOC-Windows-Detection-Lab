\# MITRE ATT\&CK Mapping



This lab focuses on Windows security telemetry and does not claim that the observed lab activity represents a confirmed attack.



\## Account Creation



Observed:

Windows Event ID 4720



Relevant ATT\&CK concept:



T1136 — Create Account



\---



\## Account / Group Modification



Observed:



Event ID 4728

Event ID 4732



Relevant ATT\&CK concept:



T1098 — Account Manipulation



\---



\## PowerShell Execution



Observed:



Windows Event ID 4688

Sysmon Event ID 1



Relevant ATT\&CK concept:



T1059.001 — PowerShell



\---



\## Network Activity



Observed:



Sysmon Event ID 3



The event provides network telemetry associated with a process.



Network telemetry alone does not establish malicious activity.

