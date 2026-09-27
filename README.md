\# Windows SOC Investigation \& Detection Lab



!\[Windows](https://img.shields.io/badge/Platform-Windows%20Server-blue)

!\[Active Directory](https://img.shields.io/badge/Active%20Directory-Lab-0078D4)

!\[Sysmon](https://img.shields.io/badge/Sysmon-Endpoint%20Telemetry-orange)

!\[PowerShell](https://img.shields.io/badge/PowerShell-Automation-5391FE)

!\[MITRE ATT\&CK](https://img.shields.io/badge/MITRE%20ATT%26CK-Mapped-red)



A hands-on Windows security monitoring and investigation laboratory focused on \*\*Active Directory, Windows Security Events, Sysmon, PowerShell, event correlation and SOC-style investigation workflows\*\*.



The project demonstrates how multiple Windows telemetry sources can be combined to reconstruct user activity and investigate authentication, identity-management, process and network events.



> \*\*Lab Environment:\*\* All activity in this project was intentionally generated in a controlled laboratory environment for educational and detection-engineering purposes.



\---



\## 🔎 Project Overview



The investigation follows a controlled activity chain:



```text

Active Directory Changes

&#x20;       │

&#x20;       ▼

Authentication

&#x20;       │

&#x20;       ├── 4624 Successful Logon

&#x20;       │

&#x20;       ▼

PowerShell Process Execution

&#x20;       │

&#x20;       ├── 4688 Process Creation

&#x20;       ├── Sysmon Event 1

&#x20;       │

&#x20;       ▼

Network Activity

&#x20;       │

&#x20;       └── Sysmon Event 3



Additional authentication failure telemetry was generated through Event ID 4625.



The project focuses on correlation and context, rather than treating individual events as automatically malicious.



🎯 Objectives



The main objectives of this laboratory were to:



Investigate Windows authentication events.

Analyse successful and failed logons.

Investigate Active Directory account creation.

Analyse security-group membership changes.

Investigate Windows process creation.

Monitor PowerShell execution.

Deploy and analyse Sysmon telemetry.

Correlate authentication and process activity.

Analyse endpoint network telemetry.

Investigate Group Policy authentication behaviour.

Develop PowerShell event-collection scripts.

Build a basic event-correlation workflow.

Map relevant observations to MITRE ATT\&CK.

Document the investigation using a professional SOC report.

🖥️ Lab Environment

Component	Purpose

Windows Server	Endpoint / Domain Controller

Active Directory	Identity and group management

Group Policy	Authentication and logon controls

Windows Security Logs	Authentication and AD telemetry

Sysmon	Endpoint telemetry

PowerShell	Automation and investigation

Event Viewer	Event investigation

MITRE ATT\&CK	Detection mapping

Active Directory Domain

lab.local

Test Identity

LAB\\mohammad

Test Groups

SOC-Test-Global

SOC-Test-Local



The test account was intentionally configured as a non-administrative laboratory identity.



🔐 Windows Security Events Investigated

Event ID	Description	Investigation Purpose

4624	Successful Logon	Authentication investigation

4625	Failed Logon	Failed-authentication analysis

4672	Special Privileges Assigned	Privilege/session investigation

4688	Process Creation	Process execution analysis

4720	User Account Created	Account lifecycle monitoring

4728	Member Added to Global Security Group	AD group-change monitoring

4732	Member Added to Local Security Group	AD group-change monitoring

🛡️ Sysmon Telemetry



The laboratory also used Sysmon to provide enhanced endpoint visibility.



Sysmon Event	Description

1	Process Creation

3	Network Connection

11	File Creation



Sysmon was used alongside native Windows Security events rather than as a replacement for them.



🔗 Event Correlation



One of the main investigation objectives was correlating authentication with subsequent process activity.



A successful interactive logon generated:



Event ID: 4624

Account: LAB\\mohammad

Logon Type: 2

Logon ID: 0x82E7A77



The same Logon ID was subsequently observed in a process-creation event:



Event ID: 4688

Process: powershell.exe

Logon ID: 0x82E7A77



This created the following investigation relationship:



4624 Successful Logon

&#x20;       │

&#x20;       │ Logon ID

&#x20;       ▼

4688 PowerShell Process

&#x20;       │

&#x20;       ▼

Sysmon Process Telemetry

&#x20;       │

&#x20;       ▼

Sysmon Network Telemetry



Other correlation fields considered during the investigation included:



Logon ID

Process ID

ProcessGuid

Timestamp

Account

Source Address

Parent Process

🧪 Controlled Investigation Activity



The lab intentionally generated several types of activity.



Successful Authentication

LAB\\mohammad

Logon Type: 2

Logon ID: 0x82E7A77

Failed Authentication



A controlled incorrect-password attempt generated:



Event ID: 4625

Status: 0xC000006D

Substatus: 0xC000006A

PowerShell Execution

powershell.exe -NoProfile -Command "Write-Output 'SOC-INTERACTIVE-LOGON-TEST'"

Network Telemetry



Sysmon captured controlled TCP activity involving:



Destination: 1.1.1.1

Port: 443



These activities were intentionally generated and are not presented as evidence of a real-world compromise.



🧠 Detection Philosophy



The project deliberately avoids treating individual events as automatically malicious.



For example:



PowerShell execution

&#x20;       ≠

Automatically malicious

4625 failed logon

&#x20;       ≠

Automatically brute force

Network connection

&#x20;       ≠

Automatically command \& control



Instead, the investigation considers:



Event

&#x20; +

Context

&#x20; +

Correlation

&#x20; +

Timeline

&#x20; +

User / Host

&#x20; +

Process

&#x20; +

Network



This approach reflects a practical SOC investigation methodology.



🚨 False Positive Analysis



The laboratory also demonstrates false-positive handling.



Activity	Initial Detection Concern	Lab Interpretation

PowerShell	Script execution	Controlled benign command

4625	Possible credential attack	Intentional incorrect password

1.1.1.1:443	Network activity	Controlled test connection

MpCmdRun.exe	Security-tool execution	Legitimate Defender maintenance

4728 / 4732	Security-group modification	Intentional lab administration

🗂️ Repository Structure

SOC-Windows-Detection-Lab/

│

├── README.md

├── .gitignore

│

├── documentation/

│   ├── Windows-SOC-Investigation-Report.docx

│   ├── incident-report.md

│   ├── README.md

│   └── references.md

│

├── evidence/

│   ├── gpo/

│   ├── authentication/

│   ├── process-monitoring/

│   ├── sysmon/

│   └── active-directory/

│

├── detection/

│   ├── event-4624.md

│   ├── event-4625.md

│   ├── event-4672.md

│   ├── event-4688.md

│   ├── event-4720.md

│   ├── event-4728.md

│   ├── event-4732.md

│   ├── event-matrix.md

│   └── detection-summary.md

│

├── scripts/

│   ├── collect-security-events.ps1

│   ├── collect-sysmon-events.ps1

│   └── correlation.ps1

│

└── mitre/

&#x20;   └── attack-mapping.md

⚙️ PowerShell Automation



The project includes PowerShell scripts for:



Security Event Collection

scripts/collect-security-events.ps1



Collects selected Windows Security events:



4624

4625

4672

4688

4720

4728

4732

Sysmon Collection

scripts/collect-sysmon-events.ps1



Collects:



Sysmon 1

Sysmon 3

Sysmon 11

Event Correlation

scripts/correlation.ps1



Provides basic Logon ID-based correlation across Windows Security events.



🧩 MITRE ATT\&CK Mapping



Relevant ATT\&CK techniques identified from observed behaviour include:



Observation	Technique

Account creation	T1136 — Create Account

Account/group modification	T1098 — Account Manipulation

PowerShell execution	T1059.001 — PowerShell



Network activity is documented as telemetry only and is not automatically mapped to a malicious network technique.



📊 Investigation Timeline

Date / Time	Event	Activity

18/04/2026	4720	mohammad account creation

26/09/2026 19:50:09	4728	Added to SOC-Test-Global

26/09/2026 19:51:20	4732	Added to SOC-Test-Local

27/09/2026 01:53:02	4624	Successful interactive logon

\~01:55	4688	PowerShell process creation

\~01:55	Sysmon 1	Process telemetry

\~01:58	Sysmon 3	Network connection

27/09/2026 01:59:51	4625	Failed interactive logon

📄 Investigation Report



The complete professional investigation report is available here:



Windows SOC Investigation Report



The report contains:



Executive Summary

Lab Objectives

Lab Environment

Active Directory Investigation

Group Policy Investigation

Windows Security Event Analysis

Sysmon Investigation

Event Correlation

Investigation Timeline

Detection Logic

False Positive Analysis

MITRE ATT\&CK Mapping

SOC Analyst Workflow

Lessons Learned

Evidence Register

📸 Evidence



The evidence/ directory contains the supporting screenshots collected during the laboratory.



Evidence is organised by investigation area:



evidence/

├── gpo/

├── authentication/

├── process-monitoring/

├── sysmon/

└── active-directory/



The screenshots provide visual evidence for the events and configurations discussed in the report.



📚 Skills Demonstrated



This project demonstrates practical experience with:



Windows Security Event Analysis

Active Directory

Group Policy

Windows Authentication

Event Correlation

Sysmon

PowerShell

Process Investigation

Network Telemetry

Detection Engineering

False Positive Analysis

MITRE ATT\&CK

SOC Investigation Methodology

Technical Documentation

⚠️ Disclaimer



This repository documents a controlled educational security laboratory.



All accounts, authentication attempts, process executions, group changes and network activity described in the project were intentionally generated within the lab environment.



The project does not represent a confirmed real-world security incident.



👤 Author



Mohammad Mohammadi



MSc Computer Forensics and Cyber Security



Areas of interest:



SOC Analysis

DFIR

Windows Security

Active Directory Security

Detection Engineering

Threat Detection

