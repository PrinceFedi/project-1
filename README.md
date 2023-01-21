# UOCIS322 - Project 1 #

This project will get you started with creating a simple webpage server.

## Getting started

Directory structure:

* the "pages" (HTML files and their assets) will be located in DOCROOT. For this project that location is the `pages/` directory. Make sure you specify this in your `credentials.ini`!

* Everything that's located in `pageserver/`. That consists of a Python application (`pageserver.py`) that starts listening at a specified port and handles requests. This is the key file you'll be editing for this project.

* There's a configuration parser, much like the one seen in [project-0](https://github.com/UO-CIS322/project-0), but a more detailed version. It not only looks for your `credentials.ini` file, both in `pageserver/` and the parent directory and falls back to `default.ini` if missing, it also allows you to override those settings through CLI. These will be discussed in the lab.

* `Makefile` here refers to the two scripts provided: `start.sh` and `stop.sh`. The former starts the server, by calling `pageserver.py`. It will also store its PID (process id), in order to kill it later through `stop.sh`. However, if you notice that it failed to do so, you can kill it manually by looking up the PID.

## Tasks

The goal of this project is to implement a "file checking" logic for the existing server. Currently, if you set it up and start the server, it will just serve a page with a cat figure. What is expected is for the server to handle the requests as follows:

* If a file exists in `pages/` (i.e. `trivia.html`, any name, any extention or format) exists, transmit `200 OK` header followed by that file. If the file doesn't exist, transmit `404 Not Found` error code in the header along with a message in the body explaining further. If a request includes illegal characters (`..` or `~`), the response should be a `403 Forbidden` error, again with a message in the body explaining it.

* Update `README` with your name, info, and a brief description of the project.

* You will submit your credentials.ini in Canvas. It should include your name and repo URL.

## Details

##### DOCROOT:

Initially, I began my process of implementing the "file checking" logic discussed by creating a copy of the credentials-skel.ini file into my official credential.ini file, with the added modification of my DOCROOT key-value pair to the parent directory containing the files we will be testing. This is a crucial step as this change was crucial in creating a way to check if the file path exist when communicating with the socket. 
I also modified the `PORT` to store the specified port I was communicating with. 

##### PAGESERVER:

As explained above, pageserver.py is a python application that listens to a specified port and handles request. In this module, most of my work centered around the respond function which initially responded to any GET request and answered back with an answered with an ascii graphic of a cat. Listed below are the steps in chronological order that I took to gather the information to implement my solution:

* Identified that our GET request was parsed into a list of strings and from there located the index upon which the inputted file  (i.e. `trivia.html`) is stored
* In the existing conditional block which checks for any GET request, I wrote three additional conditional cases that tested the following:

  1. If the `FILE EXIST`, read the contents of the file and transmit it to the local host server port. This was done using the os library method `os.path.exist` which allows us to check whether a file path exist or not. From there it was a matter of simply opening the file and transmitting it contents back to the server as well as 200 OK status using the module level argument `STATUS_OK`. 
     
     * Note: In order to get the correct path, DOCROOT needed to be imported. Luckily, the logic for it was already contained thanks to our main function that imported `config.py` which traced back to DOCROOT key. By using the `get.options()` helper method which returns namespace (that is, object) of configuration
        values, I was able to import and store the value of DOCROOT which was modifeid as explained earlier. Function signatures such as `repsponse()` and `serve()` were refactored to incoperate this variable.
  
  2. If an `ILLEGAL CHARACTER` is inputted within the request, transmit a 403 Forbidden error using the module level argument `STATUS_FORBIDDEN` followed by a string explaining what happened.
  3. For our `FILE NOT FOUND` case, if none of cases above occur, we transmit it as a 404 Not Found error using the module level argument `STATUS_NOT_FOUND`. Like the previous case above, a string expressing the error was created as well.

Once this logic, I began testing by using the command `make start` from the Makefile in the terminal to start listening to the port on the local host socket. From there, I opened my browser and made a GET request to this specific port (i.e. `http://localhost:5000/trivia.html`) which then allowed me to see the contents of the html and css file.

##### Additional notes
* Renamed process id file `$ mv pypid, pypid` to fix side effect that prevented port connection from failing gracefully upon make command usage 
* Typo caught and modified in `config.py`



## Authors

Fedi Aniefuna