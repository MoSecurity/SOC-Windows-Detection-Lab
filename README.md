# Windows SOC Investigation & Detection Lab

![Windows](https://img.shields.io/badge/Platform-Windows%20Server-blue)
![Active Directory](https://img.shields.io/badge/Active%20Directory-Lab-0078D4)
![Sysmon](https://img.shields.io/badge/Sysmon-Endpoint%20Telemetry-orange)
![PowerShell](https://img.shields.io/badge/PowerShell-Automation-5391FE)
![MITRE ATT&CK](https://img.shields.io/badge/MITRE%20ATT%26CK-Mapped-red)

A hands-on Windows SOC investigation laboratory focused on **Active Directory, Windows Security Events, Sysmon, PowerShell, event correlation, and detection engineering**.

The project demonstrates how multiple Windows telemetry sources can be combined to investigate authentication, identity changes, process execution, and network activity.

> **Lab Environment:** All activity was intentionally generated in a controlled laboratory environment for educational and detection-engineering purposes.

---

## Investigation Overview

The laboratory follows a controlled investigation workflow:

```text
Active Directory Changes
        |
        v
Authentication
        |
        +--> Event 4624 — Successful Logon
        |
        v
Process Execution
        |
        +--> Event 4688 — Process Creation
        +--> Sysmon Event 1 — Process Creation
        |
        v
Network Telemetry
        |
        +--> Sysmon Event 3 — Network Connection

A controlled failed authentication was also investigated using Event ID 4625.

Key Events Investigated
Event	Description	Investigation Area
4624	Successful Logon	Authentication
4625	Failed Logon	Authentication
4672	Special Privileges Assigned	Privilege / Session Analysis
4688	Process Creation	Process Investigation
4720	User Account Created	Active Directory
4728	Global Group Membership Change	Active Directory
4732	Local Group Membership Change	Active Directory
Sysmon
Event	Description
1	Process Creation
3	Network Connection
11	File Creation
Event Correlation

A key investigation objective was correlating authentication with subsequent process activity.

Example:

Event 4624
LAB\mohammad
Logon Type: 2
Logon ID: 0x82E7A77
        |
        v
Event 4688
PowerShell
Logon ID: 0x82E7A77
        |
        v
Sysmon Event 1
Process Telemetry
        |
        v
Sysmon Event 3
Network Telemetry

Correlation was based on identifiers including:

Logon ID
Process ID
ProcessGuid
Timestamp
Account
Source Address
Parent Process
Active Directory

The laboratory used the following controlled identity configuration:

Domain

lab.local

Test Account

LAB\mohammad

Security Groups

SOC-Test-Global
SOC-Test-Local

The account was intentionally configured as a non-administrative test identity.

Detection Philosophy

Individual events are not automatically classified as malicious.

For example:

PowerShell execution
        !=
Automatically malicious
4625 Failed Logon
        !=
Automatically brute force
Network Connection
        !=
Automatically Command & Control

The investigation instead considers:

Event + Context + Correlation + Timeline + User + Process + Network

This approach is designed to reduce false positives and improve investigation quality.

False Positive Analysis
Activity	Potential Concern	Lab Interpretation
PowerShell	Script execution	Controlled benign command
4625	Possible credential attack	Intentional incorrect password
1.1.1.1:443	Network activity	Controlled test connection
MpCmdRun.exe	Security-tool execution	Legitimate Defender maintenance
4728 / 4732	Group modification	Intentional lab administration
MITRE ATT&CK

Relevant techniques identified from observed behaviour:

Observation	Technique
Account creation	T1136 — Create Account
Account/group modification	T1098 — Account Manipulation
PowerShell execution	T1059.001 — PowerShell

Network activity is documented as telemetry and is not automatically classified as malicious command-and-control activity.

Repository Structure
SOC-Windows-Detection-Lab/
│
├── README.md
├── .gitignore
│
├── documentation/
│   └── Windows-SOC-Investigation-Report.docx
│
├── evidence/
│   ├── active-directory/
│   ├── authentication/
│   ├── gpo/
│   ├── process-monitoring/
│   └── sysmon/
│
├── detection/
│   ├── detection-summary.md
│   └── event-matrix.md
│
├── scripts/
│   ├── collect-security-events.ps1
│   ├── collect-sysmon-events.ps1
│   └── correlation.ps1
│
└── mitre/
    └── attack-mapping.md
Evidence

Supporting screenshots are stored in the evidence/ directory.

Evidence is organised into:

Active Directory
Authentication
Group Policy
Process Monitoring
Sysmon

The evidence supports the observations documented in the investigation report.

Investigation Report

The complete professional investigation report is available here:

Windows SOC Investigation Report

The report covers:

Executive Summary
Lab Environment
Active Directory Investigation
Group Policy Investigation
Windows Security Event Analysis
Sysmon Investigation
Event Correlation
Investigation Timeline
Detection Logic
False Positive Analysis
MITRE ATT&CK Mapping
SOC Analyst Workflow
Lessons Learned
Conclusion
Skills Demonstrated
Windows Security Event Analysis
Active Directory
Group Policy
Windows Authentication
Sysmon
PowerShell
Event Correlation
Process Investigation
Network Telemetry
Detection Engineering
False Positive Analysis
MITRE ATT&CK
SOC Investigation
Technical Documentation
Disclaimer

This repository documents a controlled educational security laboratory.

All accounts, authentication attempts, process executions, group changes, and network activity described in this project were intentionally generated within the lab environment.

The project does not represent a confirmed real-world security incident.

Author

Mohammad Mohammadi

MSc Computer Forensics and Cyber Security

Focus Areas:

SOC Analysis
DFIR
Windows Security
Active Directory Security
Detection Engineering
Threat Detection
