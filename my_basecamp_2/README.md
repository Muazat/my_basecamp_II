# Welcome to My Basecamp 2
***

## Task
The task is to build a rails app that has user with roles of admins and or not. Also the users should be able to create projects, upload files and create discussion and comment

## Description
The Task has different models that uses both one-to-many and many-to-many relationship 

A user can be an admin or an ordinary user
Roles of a User:
1. Can create, view (project where he/she has membership status), delete and edit owns projects.
2. Can add users to a project where he or she has an admin status.
3. can add files to projects he or she belongs to.
4. Can create a thread, edit and delete a project where he or she has an admin status
5. can add, edit and delete comments (can also delete other users comments if he or she is an admin to the project)
6. All users can attach files to the projects they belong to

In addition to the roles of a user an admin has the following privileges:
* can view, delete and edit all projects
* Can view, change the role of a user and delete users
* can start a thread and delete a thread in all projects
* can add, edit and delete comments (can also delete other users comments)

## Installation
The task is done using ruby on rails, it also uses the amazon s3 bucket for files storage and can be accessed through the browser

## Usage
The user can be created through the frontend
An Admin can only be created through the console(on your local machine) using the format below:

1. run the command: rails console

2. create a new user using the format below:
User.create(surname: "Fakile", firstName: "Bayo", email: "bayo@gmail.com", password: "bayo", isAdmin: true)

Also an already created admin login details given below can be used to have access to the application as an admin on the hosted site:

email: admin@gmail.com
password: admin22

or

email: muazat'kabara1999@gmail.com
password: muazat

## LINK
https://basecamp2.fly.dev/

### The Core Team
Muazat Bello (muazat.kabara1999@gmail.com)


<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px'></span>


