\# Detection Summary



\## Authentication Monitoring



\### Detection: Failed Interactive Logon



Event ID: 4625



Relevant fields:



\- Account Name

\- Account Domain

\- Logon Type

\- Failure Reason

\- Status

\- Sub Status

\- Source Network Address



Example observed activity:



LAB\\mohammad generated a failed interactive logon with a bad password.



\---



\## Detection: Successful Interactive Logon



Event ID: 4624



Relevant fields:



\- Account Name

\- Account Domain

\- Logon Type

\- Logon ID

\- Source Network Address



The lab successfully generated a Type 2 interactive logon for LAB\\mohammad.



\---



\## Process Monitoring



\### Detection: PowerShell Process Creation



Event ID: 4688



Relevant fields:



\- New Process Name

\- Process Command Line

\- New Process ID

\- Creator Process ID

\- Logon ID

\- Token Elevation Type



PowerShell execution was correlated with the user's logon session.



\---



\## Sysmon Process Monitoring



\### Sysmon Event ID 1



Provides detailed process creation telemetry including:



\- Image

\- CommandLine

\- User

\- ProcessId

\- ParentProcessId

\- ProcessGuid

\- IntegrityLevel



\---



\## Network Monitoring



\### Sysmon Event ID 3



Provides:



\- Source IP

\- Destination IP

\- Destination Port

\- Protocol

\- Process ID

\- Process GUID

\- User



The lab correlated PowerShell execution with an outbound TCP connection to 1.1.1.1:443.



\---



\## Active Directory Monitoring



\### Event ID 4720



Detects user account creation.



\### Event ID 4728



Detects addition of a member to a security-enabled global group.



\### Event ID 4732



Detects addition of a member to a security-enabled local/domain-local group.



\---



\## Investigation Principle



Individual events should not automatically be treated as malicious.



Analysts should correlate:



Authentication

→ Account activity

→ Process execution

→ Network activity

→ File activity



and evaluate the surrounding context before assigning severity.

