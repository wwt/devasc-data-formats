# DEVASC Data Encoding Formats Hands-On

## :fontawesome-solid-laptop-code: About

When we apply automation to IT systems, we get the fantastic benefit of _not_ having to either copy and paste configuration changes to dozens (maybe hundreds) of different systems or repeat the same click, click, click, click, click-through-the-UI marathon over, and over, and over...whenever there's a need to make a bulk change :rage:.  Learning to write the code which performs automation is essential and _equally_ essential is learning to read and write the **data structures** that our code sends to and receives from the systems we automate.

### :fontawesome-solid-file-code: Unstructured vs Structured Data

#### Data Meant for Humans to Read

When we interact with the CLI of a network device, server, storage system, cloud compute platform, etc., we typically send text commands and receive text responses.  Typically, the responses to our commands are plain text in an **unstructured** format.  Usually, spaces, tabs, numbering, and even text-based graphics or tables format the presentation the raw data we need in a way that is easy for humans to read.

When a computer, such as an automtion system, tries to read that same, **unstructured** data, it is usually necessary to tell the computer how to search (or parse) through all of the spaces, special characters, and text graphics to find the specific data it needs.  Parsing through unstructured data is often difficult (for humans) to configure, temperamental to successfully test, and a headache to maintain.  Anytime an IT system undergoes a software or hardware change, the format of a unstructured command response can change, even if by a single character, and cause a parser to fail or, often worse, work improperly.

#### Data Meant for Computers to Read

So, how do we implement automated workflows for IT systems and avoid daily work comsumed by the "fun" of writing and maintaining text parsers?  Fortunately, most IT systems have programmatic interfaces, referred to as APIs, which can send and receive configuration or operational state/status data in a **structured** format.  Some of the more common **structured** data formats include JSON, XML, and YAML.

Each of these **structured data encoding formats** are much easier for computers to read because the **structure** of the data adheres to a standard format which IT systems and programming languages can read without text parsers.

#### Example Network Device CLI and API Response Data

You might be thinking, _"Why would I every want to work with **unstructured** data?"_  Well, if you need to interact with an IT system via it's CLI, **unstructured** data is a bit easier on the eyes than **structured** data.  JSON, XML, and YAML are all human-readable formats although, when you take a look at the example below, you will notice a _slight_ (insert sarcasam here) difference between the CLI and API formats, for the exact same data:

???+ example "Example Network Device CLI and API Response Data"

    === "CLI Response Output - Unstructured Data"
        ```text
        --8<-- "includes/cli_data.txt"
        ```

    === "API Response Output - Structured Data"

        ```xml
        --8<-- "includes/xml_data.xml"
        ```

---

## :fontawesome-solid-lightbulb: Overview

This repo has several guided, hands-on exercises which will help you learn and practice how to use various data encoding formats with Python.  These exercises compliment the *Data Encoding Formats* presentation which is available in the Study Group files repository.

---

## :fontawesome-solid-flask: Hands-On Lab Setup

The **Lab Setup** section has step-by-step directions to help you deploy the learning materials using a guided, interactive Python tool called [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/getting_started/overview.html).

---

## :fontawesome-solid-flag: Getting Started

--8<-- "includes/glossary.txt"
