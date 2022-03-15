# UltraTech Writeup (THM)

### tags
* security
* pentest
* enumeration
* web

### set of questions 1
* which software is using the port 8081 ?
* which other non-standard port is used ?
* which software using this port ?
* which GNU/Linux distribution seems to be used ?
* the software using the port 8080 is a REST api, how many of its routes are used by the web application ?

### set of questions 2
* There is a database lying around, what is its filename? 
* What is the first user's password hash?
* What is the password associated with this hash?

### set of questions 3
* What are the first 9 characters of the root user's private SSH key? 

---

## set of questions 1

we ping the target and the ICMP TTL indicates us that it's a Linux Machine  
![](./contents/screenshots/screenshot1.png)  

with nmap we discover 4 open ports  
![](./contents/screenshots/screenshot2.png)  

this is enough to answer the first 4 questions :  
* *which software is using the port 8081 ?* 		**Node.js**
* *which other non-standard port is used ?* 		**31331**
* *which software using this port ?* 			**Apache**
* *which GNU/Linux distribution seems to be used ?*	**Ubuntu**

the last question is *the software using the port 8080 is a REST api, how many of its routes are used by the web application ?*  
i suppose they are talking about the 8081 port, not 8080  
now we use gobuster on the port 8081 to find the routes and we find 2, */auth* and */ping*

---

## set of questions 2

now we use gobuster on port 31331 and we discover the login page */partners.html*  
looking the code, we can see that it's using the API on port 8081  
every 10 seconds, it uses */ping?ip=<***IP***>* to confirm that the host is up  
when we try to log in, it uses */auth?login=<***username***>&password=<***password***>*  

i confirm that */ping* is using the command **ping**, so it might vulnerable to **command injection**  
after some tries, this is the injection that works for me  
![](./contents/screenshots/screenshot3.png)  

since i'm not able to make it display the output, i send the output of "ls -lha" to a file, and send it to my machine with curl  
![](./contents/screenshots/screenshot4.png)  
![](./contents/screenshots/screenshot5.png)  
![](./contents/screenshots/screenshot6.png)  

we see that the answer to the question *There is a database lying around, what is its filename?* is **utech.db.sqlite**  

we use the same technique to transfer de ddbb to our machine  
we see the user **r00t** with the hash **f357a0c52799563c7c7b76c1e7543a32**  
we search the hash on google, and we find [this page](https://md5.j4ck.com/14777) that includes that hash  
the unhashed password is **n100906**  

so we have answered the remaining questions, and we have the credentials **r00t:n100906** that work on */partners.html*  
Great !!!

---



