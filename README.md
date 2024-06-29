# Social-Ministry-database-System
In this document, you will find a brief explanation about the new Social Ministry database system, which will be used mainly to store and retrieve information about beneficiaries, trainers, organizers, and head organizers. Each user's access permissions are outlined to demonstrate how the system implements privileges and restrictions, ensuring effective and secure data management. This documentation describes the functionalities and architecture of our database system, focusing on system requirements, design (GUI), implementation processes, and system architecture. It provides instructions for the software technologies used and outlines the procedures and access for specific users such as ministry organizers and heads. This report focuses on everything from the user’s point of view and serves as a consistent reference for users.

#Physical Schema
A physical schema of the overall system 

#Database Development
- Database Overview
The database consists of several tables, each serving a specific purpose within the system. Below is an overview of the primary tables and their attributes:

- Beneficiary: Stores beneficiary data including ID, names, sex, date of birth, and department.
- Course: Stores course information such as ID, name, credit hours, prerequisites, description, delivery method, and enrollment capacity.
- Organizer: Contains organizer data including ID, names, starting date, salary, and employment date.
- Program: Holds program information like ID, name, and level.
- Schedule: Tracks schedules for beneficiaries, trainers, and organizers, including start dates and status.
- Trainer: Stores trainer data including ID, course ID, names, and expertise.
- Beneficiary_Addresses: Manages beneficiary addresses.
- Beneficiary_Emails: Manages beneficiary emails.
- Beneficiary_PhoneNumbers: Manages beneficiary phone numbers.
- Course_Location: Manages course locations.
- Course_Program: Manages the relationship between courses and programs.
- Course_Schedule: Manages the relationship between courses and schedules.
- Organizer_PhoneNumbers: Manages organizer phone numbers.
- Program_Organizer: Manages the relationship between programs and organizers.
- Trainer_PhoneNumbers: Manages trainer phone numbers.
- Program_Beneficiary: Manages the relationship between programs and beneficiaries.
#Security
Security is a crucial aspect of the system, with specific privileges granted to different user roles to ensure data integrity and confidentiality. Below is a summary of user roles and their respective privileges:
- Head Organizer: Has full access to view, insert, update, and delete records related to beneficiaries, organizers, programs, and courses.
- Organizer (e.g., Hassan Farsi): Can execute specific procedures to manage programs and courses and has selective access to relevant tables.
- Trainer (e.g., Jane Smith): Can update and view courses they are responsible for and view their schedules.
- Beneficiary (e.g., Khaled Mohammed): Can view their schedules and available courses.
#User Interface
- Flowchart and Data Movement Diagrams
The user interface includes various diagrams to illustrate data flow and interactions for different user roles:
- Beneficiary: Interacts with their schedule and course information.
- Trainer: Manages and views courses they are responsible for.
- Organizer: Manages programs, courses, and schedules.
- Head Organizer: Oversees all aspects of the database, ensuring data integrity and smooth operations.
#Interfaces Development
The user interface consists of several pages, each designed to facilitate specific tasks for the users:

- Home Page: Allows the head organizer to view and navigate to tables they have permission to edit.
- Organizer View Table: Displays records from the organizer table with options to edit, delete, or add records.
- Editing Record Page: Enables editing of selected record attributes.
- Deleting Record: Provides cautionary confirmation before deleting a record.
- Adding Record: Allows the addition of new records with options to save or cancel.
- Error Page: Displays error messages for actions that violate constraints, such as duplicate primary key entries.

An overview of the general implementations done in the sql file was breiefly described along side general structure of the main thecnical documentaion that you can view
to further view more specific details of the project.

#Contributing: Contributions are welcome! Please open an issue or submit a pull request for any enhancements, bug fixes, or documentation improvements.

#Acknowledgements: 
Structured Query Language (SQL), Microsoft SQL management studio
