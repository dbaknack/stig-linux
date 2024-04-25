# stig-linux
Practice linux fundamental concepts by STIGing linux Ubuntu.

### How to properly checkout an issue to work on
When working on a finding; in order for that to be tracked as being worked on, you will need to properly check the "issue" out. What you are essentially doing is taking a finding, and working on it locally. To do this properly; follow the steps below.

### **Step 1) Pick a finding to work on**

In [issues](https://github.com/dbaknack/stig-linux/issues), you will see all the findings that need to be remediated. None of them are assigned to anyone. you can just pick one. In this example, we will pick issue #14 `Create documentation`

### **Step 2) Adding details to issue selected**
Click on the issue. In the following page; on the right hand side, you will see `Assignees`,`Labels`, and `Projects`. Under Assignees, you will assign the issue to yourself. In Projects, under status update the status to `In Progress`

### **Step 3) Checkout the issue**

Open up VS Code. In `Source control` clone the project if you havn't already.  Save it locally on your machine and open it. once open you will open a new terminal in VS Code. in your terminal

```bash
# replace the issue number with the issue number you have selected in Step 1)

git checkout -b issue-14
```
### Complete
Once you perform the steps as defined above, you will have successfully checked out an issue.

---

### Repository structure

There is a structure to this project and for consistency, make sure to commit your changes with the structure of this project in mind.

```
├── stig-linux
│   ├── Canonical_Ubuntu_20.04_LTS_2023-12-01
│   │
│   ├── U_CAN_Ubuntu_20-04_LTS_V1R12_STIG
│   │   └── U_CAN_Ubuntu_20-04_LTS_STIG_V1R12_Manual-xccdf.xml
│   │
│   ├── Documentation
│   │   └── [enclave]_[domain]_[hostname]_DISA_STIG.md
│   │
│   ├── Supplimental_Docs
│   │   ├── [enclave]_[domainname]_[hostname]_[finding_id_01].csv
│   │   └── [enclave]_[domainname]_[hostname]_[finding_id_02].csv
│   │
│   └── Remediations
│       ├── [finding_id_01]
│       │   ├── instructions.md
│       │   ├── check.sh
│       │   └── fix.sh
│       │
│       └── [finding_id_02]
│           ├── instructions.md
│           ├── check.sh
│           └── fix.sh
│
├── README.md
├── LICENSE
└── .gitignore
```

The items to note primarily are the Documentation and Remediations folder. Documentation will hold any documentation that any finding states to document. Remediations will contain folders where the title of the folder is the finding id and within it you will always have 3 files. all findings that are remediated will come with a check.sh file, this file will be the script you use to do check check itself, see if the item you are checking is in compliance or not, the fix.sh is the script to run to remediate the item if its not in compliance, and the instructions.md are instruction on how to run your check.sh script and the fix.sh script.

Suplimental_Docs will documentation that would otherwise be to long to include in the documentation file within the Documentation folder. U_CAN_Ubuntu_20-04_LTS_V1R12_STIG is the folder that contains the checklist that you will open with the stig viewer.

---

### Commiting your changes
One you are ready to commit your changes to the repository, make sure to follow the steps below.

## **Step 1) Using key words to link to issue**
You can link a pull request to an issue by using a supported keyword in the pull request's description or in a commit message. The pull request must be on the default branch.

-   close
-   closes
-   closed
-   fix
-   fixes
-   fixed
-   resolve
-   resolves
-   resolved