# DEVASC Data Encoding Formats Hands-On

## Overview

This repo has several guided, hands-on exercises which will help you learn and practice how to use various data encoding formats with Python.  These exercises compliment the *Data Encoding Formats* presentation which is available in the Study Group files repository.

The **Lab Setup** section has step-by-step directions to help you deploy the learning materials using [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/getting_started/overview.html) within the [WWT Programmability Foundations Lab](https://www.wwt.com/lab/programmability-foundations-lab).

\*\* Note - this lab requires that you have a **GitHub *Personal Access Token (PAT)*** available with ***repo*** scope permissions \*\*

* You will authenticate to GitHub using your standard GitHub username and substitute your PAT for your password.
* Directions to setup a PAT are here -  [GitHub Personal Access Token Setup](https://docs.github.com/en/enterprise/2.15/user/articles/creating-a-personal-access-token-for-the-command-line).
* If you are a WWT employee, be sure to **enable SSO** for your PAT.



*GitHub PAT SSO Setup*:

![1_setup_pat_sso](_images/1_setup_pat_sso.png)

---



## Lab Setup

### Programmability Foundations Lab Launch

\*\*Note - The JupyterLab setup requires some copy and paste operations from your desktop to your instance of the WWT Programmability Foundations Lab.  The copy and paste experience is the most reliable when you launch the Programmability Foundations Lab with **Google Chrome**.\*\*

1. Access the [WWT Programmability Foundations Lab](https://www.wwt.com/lab/programmability-foundations-lab) landing page and click the **Launch Lab** button:

![1_lab_launch](_images/1_lab_launch.gif)


---


2. Click the **My WWT** link and click the **My Labs** button on the next page:

![2_lab_launch](_images/2_lab_launch.gif)


---


3. Click the **Access Lab** button next to your *Programmability Foundations Lab* abd click the **Open in ATC Lab Gateway** button:
   - It may take a few minutes for Windows services to start, please be patient.

![3_lab_launch](_images/3_lab_launch.gif)


---


4. Click **Skip This Build** on the *Docker Desktop Update* window and click **Dismiss** on the *Docker Feedback* window.

![4_lab_launch](_images/4_lab_launch.gif)


---


5. Expand the Windows 10 System Tray and wait for *Docker Desktop* to start.
   - A system notification will display when Docker Desktop starts; this may take several minutes.

![5_lab_launch](_images/5_lab_launch.gif)


---


### JupyterLab Launch

1. Open Windows PowerShell and then paste/run the following commands:

```powershell
# Grant Windows PowerShell permission to run unsigned scripts
Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList "Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force"
```

![1_jupyter_launch](_images/1_jupyter_launch.gif)




```powershell
# Download the configuration file
Invoke-WebRequest -Uri 'https://devnet-jupyter.s3-us-west-2.amazonaws.com/.repo' -OutFile '.repo'
```

![2_jupyter_launch](_images/2_jupyter_launch.gif)




```powershell
# Download the installation script
Invoke-WebRequest -Uri 'https://devnet-jupyter.s3-us-west-2.amazonaws.com/jupyter_launcher.ps1' -OutFile 'jupyter_launcher.ps1'
```

![3_jupyter_launch](_images/3_jupyter_launch.gif)




```powershell
# Run the installation script - the typical first installation typically takes between 3-5 minutes
.\jupyter_launcher.ps1
```

![4_jupyter_launch](_images/4_jupyter_launch.gif)



2. When prompted, enter your GitHub credentials:
   - Use your standard GitHub username.
   - Substitute your PAT for your password.

![5_jupyter_launch](_images/5_jupyter_launch.gif)



3. Access the exercises using Jupyter Notebooks:
   - Click on the repo name, **devasc-data-formats** in the Jupyter Sidebar.
   - Click on the **part_i_python** folder.
   - Click on the **python.ipynb** notebook.
   - Follow the navigation at the bottom of each notebook file.

![6_jupyter_launch](_images/6_jupyter_launch.gif)



## Navigation

---
#### Navigation
* **Home**
* [Exercise 1 - Python Objects & File Management](part_i_python/python.ipynb)
* [Exercise 2 - JSON Structured Data](part_ii_json/json.ipynb)
* [Exercise 3 - YAML Structured Data](part_iii_yaml/yaml.ipynb)
* [Exercise 4 - XML Structured Data](part_iv_xml/xml.ipynb)



