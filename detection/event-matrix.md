\# Windows SOC Detection Lab — Event Matrix



| Event ID | Source | What it means | Evidence collected | Investigation value |

|---|---|---|---|---|

| 4624 | Windows Security | Successful logon | Yes | Identifies successful authentication |

| 4625 | Windows Security | Failed logon | Yes | Authentication failure investigation |

| 4672 | Windows Security | Special privileges assigned | Yes | Privileged logon investigation |

| 4688 | Windows Security | Process creation | Yes | Process execution investigation |

| 4720 | Windows Security | User account created | Yes | Account creation monitoring |

| 4728 | Windows Security | Member added to global security group | Yes | Group membership monitoring |

| 4732 | Windows Security | Member added to local/domain-local security group | Yes | Group membership monitoring |

| 1 | Sysmon | Process creation | Yes | Detailed process telemetry |

| 3 | Sysmon | Network connection | Yes | Process-to-network correlation |

| 11 | Sysmon | File creation | Yes | File activity investigation |



\## Key Correlation Identifiers



\### Logon ID



The `Logon ID` was used to correlate authentication events with subsequent process creation events.



Example:



`4624 → Logon ID 0x82E7A77 → 4688`



\### Process ID



The Process ID was used to correlate Windows Security process creation with Sysmon process telemetry.



Example:



`4688 → PowerShell PID → Sysmon Event ID 1`



\### ProcessGuid



Sysmon `ProcessGuid` was used to correlate process activity across Sysmon events.



Example:



`Sysmon Event ID 1 → ProcessGuid → Sysmon Event ID 3`



\## Lab Account



User:



`LAB\\mohammad`



Test groups:



`SOC-Test-Global`



`SOC-Test-Local`



\## Key Investigation Chain



4720

→ Account creation



4728

→ Global security group membership change



4732

→ Local/domain-local security group membership change



4625

→ Failed authentication



4624

→ Successful interactive authentication



4688

→ Process creation



Sysmon Event 1

→ Detailed process creation



Sysmon Event 3

→ Network connection



Sysmon Event 11

→ File creation

