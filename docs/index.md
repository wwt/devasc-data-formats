# DEVASC Data Encoding Formats Hands-On Lab Guide

## :fontawesome-solid-laptop-code: Overview

When we automate to IT systems, we get the fantastic benefit of _not_ having to either copy and paste configuration changes to dozens (maybe hundreds) of different systems or repeat the same click, click, click, click, click-through-the-UI marathon over, and over, and over..._every single time_ there's a need to make a bulk change :rage:.  To automate these sorts of workflows, it's important that we learn to write some form of automation-specific code.  To make that possible, it's essential that we know how to read and write the **data structures** that our code sends to and receives from the systems we automate.

This guide will walk you through some hands-on exercises which help teach and and also give you a place to practice using various **data encoding formats** with Python.  You'll get the most from these exercises if you have at least a little bit of exposure to Python fundamentals although we put the step-by-step directions together in a way that welcomes all experience levels.

---

### :fontawesome-solid-file-code: Unstructured vs Structured Data

#### Data Meant for Humans to Read

When we interact with the CLI of a network device, server, storage system, cloud compute platform, etc., we typically send text commands and receive text responses.  Usually, the responses to our commands are plain text in an **unstructured** format.  Most times we see the raw data response formatted with a variety of spaces, tabs, numbering, tables, or even text-based graphics, to make it easier for humans to read.

---

#### Data Meant for Computers to Read

When a computer, such as an automtion system, tries to read that same, **unstructured** data, we usually have to tell the computer specifically how it should search (or parse) through all of the spaces, special characters, and text graphics to find the specific, raw data it needs.  Parsing through unstructured data is often difficult to configure, temperamental to successfully test, and a headache to maintain.  Anytime an IT system undergoes a software or hardware change, the format of an unstructured command response can change, even if by a single character, and cause a parser to fail or work improperly.

---

#### APIs and Data Formats

So, how do we implement IT automation workflows and avoid having our lives comsumed by the "joy" of writing and maintaining text parsers?  Fortunately, most IT systems have programmatic interfaces, referred to as APIs, which can send and receive configuration or state/status data in a **structured** format.  Some of the more common **structured** data formats include JSON, XML, and YAML.

Each of these **structured data encoding formats** are much easier for computers to read because the **structure** of the data adheres to a standard format which IT systems and programming languages can read without text parsers.

---

## :fontawesome-solid-code: A Practical Example

Here is a real example of some data that a network device sent in response to a request from each its CLI and its API.  Now, unless you happen to be a computer, you will probably find the CLI example (**unstructured data**) a bit easier to read than the API example (**structured data**).

---

### :fontawesome-regular-file-code: A Side-by-Side Comparision

???+ abstract "Example Network Device CLI and API Response Data"

    Even though the CLI and API data formats look drastically different, they both provide the _exact_ same data.

    === "CLI Response Output - Unstructured Data"
        ```text
        --8<-- "includes/data_cli.txt"
        ```

    === "API Response Output - Structured Data"

        ```xml
        --8<-- "includes/data_xml.xml"
        ```

---

### :fontawesome-brands-python: Comparing the Code

If you're thinking, _"Why would I ever want to deal with **structured data**? It looks like a mess!"_  Well, to put it simply, **structured data** is _way_ easier to work with **programmatically**.  Take a look at how we might parse both the CLI and API responses with some Python code:

???+ note "Example Code Exercise"

    The goal of this exercise is to parse the interface ID from each the CLI and API response data sets.  For reference, the correct result of a search for the interface ID is the text **1/10**.  These examples assume the CLI and API data are already available to the Python interpreter, in the variable with the name **`data`**.

    - Even though the CLI response data is only a few lines long, the Python code to parse the interface ID from that data, with a regular expression, is lengthy and somewhat complex to read.
    - By contrast, even though the API response data is lenghty, the Python code to parse the interface ID is short and far less complex to read.

    ??? example "Click to view the code examples"

        === "Parse the Unstructured (CLI) Response"
            ```python linenums="1" hl_lines="5-17 19 21-24"
            --8<-- "includes/parse_unstructured.py"
            ```
    
        === "Parsing the Structured (API) Response"
            ```python linenums="1" hl_lines="5-8"
            --8<-- "includes/parse_structured.py"
            ```

---

All right, that's enough reading for now.  It's time to get into the lab exercises and get some real practice.  If everything to this point makes perfect sense to you, great!  If not, don't worry because you're about to get a lot of hands-on repetitions with functional code.  [Click here to continue to the next section](sections/section_1.md "Hands-On Lab Setup").

--8<-- "includes/glossary.txt"
