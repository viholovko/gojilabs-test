# University Course Scheduling System

## Overview

The University Course Scheduling System is a web application designed to manage courses, sections, classrooms, teachers, and students. It allows students to enroll in courses, manage their schedules, and download their schedules in PDF format. The system ensures that students do not enroll in overlapping sections.

## Features

- Manage teachers, subjects, classrooms, and students.
- Create and manage sections that link teachers, subjects, and classrooms.
- Students can add or remove sections from their schedules.
- Conflict detection to prevent overlapping sections.
- Downloadable PDF schedules for students.

## Technologies Used

- Ruby on Rails
- PostgreSQL (or your preferred database)
- RSpec for testing
- Prawn for PDF generation
- Swagger (via rswag) for API documentation

## Installation

### Prerequisites

- Ruby (version 2.7 or higher)
- Rails (version 6.0 or higher)
- PostgreSQL (or your preferred database)

### Steps

1. **Clone the repository:**

   ```bash
   git clone https://github.com/viholovko/gojilabs-test.git
   cd gojilabs-test
   ```

2. **Install dependencies:**

   ```bash
   bundle install
   ```

3. **Set up the database:**

   ```bash
   rails db:create
   rails db:migrate
   rails db:seed # Optional: to seed the database with initial data
   ```

4. **Start the Rails server:**

   ```bash
   rails server
   ```

5. **Access the application:**

   Open your web browser and navigate to `http://localhost:3000`.

## API Documentation

### API Endpoints

The following API endpoints are available for managing the university course scheduling system. Each endpoint includes the HTTP method, URL, request parameters, and example responses.

#### 1. Students

- **GET /api/v1/students**
  - **Description**: Retrieve a list of all students.
  - **Response**:
    ```json
    [
      {
        "id": 1,
        "name": "John Doe",
        "email": "john.doe@example.com"
      },
      {
        "id": 2,
        "name": "Jane Smith",
        "email": "jane.smith@example.com"
      }
    ]
    ```

- **POST /api/v1/students**
  - **Description**: Create a new student.
  - **Request Body**:
    ```json
    {
      "student": {
        "name": "John Doe",
        "email": "john.doe@example.com"
      }
    }
    ```
  - **Response**:
    - **201 Created**:
      ```json
      {
        "id": 1,
        "name": "John Doe",
        "email": "john.doe@example.com"
      }
      ```
    - **422 Unprocessable Entity** (if validation fails):
      ```json
      {
        "error": {
          "email": ["has already been taken"]
        }
      }
      ```

- **GET /api/v1/students/:id**
  - **Description**: Retrieve a specific student by ID.
  - **Response**:
    - **200 OK**:
      ```json
      {
        "id": 1,
        "name": "John Doe",
        "email": "john.doe@example.com"
      }
      ```
    - **404 Not Found** (if student does not exist):
      ```json
      {
        "error": "Student not found"
      }
      ```

- **POST /api/v1/students/:id/add_section/:section_id**
  - **Description**: Add a section to a student's schedule.
  - **Response**:
    - **200 OK**:
      ```json
      [
        {
          "id": 1,
          "subject": "General Chemistry",
          "start_time": "08:00",
          "end_time": "08:50",
          "teacher_name": "Dr. Smith",
          "classroom_name": "Room 101"
        }
      ]
      ```
    - **422 Unprocessable Entity** (if there is a conflict):
      ```json
      {
        "error": "Section conflicts with existing schedule"
      }
      ```

- **DELETE /api/v1/students/:id/remove_section/:section_id**
  - **Description**: Remove a section from a student's schedule.
  - **Response**:
    - **200 OK**:
      ```json
      [
        {
          "id": 1,
          "subject": "General Chemistry",
          "start_time": "08:00",
          "end_time": "08:50",
          "teacher_name": "Dr. Smith",
          "classroom_name": "Room 101"
        }
      ]
      ```

- **GET /api/v1/students/:id/schedule**
  - **Description**: Download a student's schedule as a PDF.
  - **Response**:
    - **200 OK** (PDF file download).

#### 2. Sections

- **GET /api/v1/sections**
  - **Description**: Retrieve a list of all sections.
  - **Response**:
    ```json
    [
      {
        "id": 1,
        "subject": "General Chemistry",
        "teacher": "Dr. Smith",
        "classroom": "Room 101",
        "start_time": "08:00",
        "end_time": "08:50",
        "days": "MWF"
      }
    ]
    ```

- **POST /api/v1/sections**
  - **Description**: Create a new section.
  - **Request Body**:
    ```json
    {
      "section": {
        "teacher_id": 1,
        "subject_id": 1,
        "classroom_id": 1,
        "start_time": "08:00",
        "end_time": "08:50",
        "days": "MWF"
      }
    }
    ```
  - **Response**:
    - **201 Created**:
      ```json
      {
        "id": 1,
        "subject": "General Chemistry",
        "teacher": "Dr. Smith",
        "classroom": "Room 101",
        "start_time": "08:00",
        "end_time": "08:50",
        "days": "MWF"
      }
      ```
    - **422 Unprocessable Entity** (if validation fails):
      ```json
      {
        "error": {
          "start_time": ["can't be blank"]
        }
      }
      ```

- **GET /api/v1/sections/:id**
  - **Description**: Retrieve a specific section by ID.
  - **Response**:
    - **200 OK**:
      ```json
      {
        "id": 1,
        "subject": "General Chemistry",
        "teacher": "Dr. Smith",
        "classroom": "Room 101",
        "start_time": "08:00",
        "end_time": "08:50",
        "days": "MWF"
      }
      ```
    - **404 Not Found** (if section does not exist):
      ```json
      {
        "error": "Section not found"
      }
      ```

- **PUT /api/v1/sections/:id**
  - **Description**: Update a specific section.
  - **Request Body**:
    ```json
    {
      "section": {
        "start_time": "09:00",
        "end_time": "09:50"
      }
    }
    ```
  - **Response**:
    - **200 OK**:
      ```json
      {
        "id": 1,
        "subject": "General Chemistry",
        "teacher": "Dr. Smith",
        "classroom": "Room 101",
        "start_time": "09:00",
        "end_time": "09:50",
        "days": "MWF"
      }
      ```
    - **422 Unprocessable Entity** (if validation fails):
      ```json
      {
        "error": {
          "start_time": ["can't be blank"]
        }
      }
      ```

- **DELETE /api/v1/sections/:id**
  - **Description**: Delete a specific section.
  - **Response**:
    - **204 No Content** (if successfully deleted).

#### 3. Classrooms

- **GET /api/v1/classrooms**
  - **Description**: Retrieve a list of all classrooms.
  - **Response**:
    ```json
    [
      {
        "id": 1,
        "name": "Room 101"
      }
    ]
    ```

- **POST /api/v1/classrooms**
  - **Description**: Create a new classroom.
  - **Request Body**:
    ```json
    {
      "classroom": {
        "name": "Room 102"
      }
    }
    ```
  - **Response**:
    - **201 Created**:
      ```json
      {
        "id": 2,
        "name": "Room 102"
      }
      ```
    - **422 Unprocessable Entity** (if validation fails):
      ```json
      {
        "error": {
          "name": ["can't be blank"]
        }
      }
      ```

- **GET /api/v1/classrooms/:id**
  - **Description**: Retrieve a specific classroom by ID.
  - **Response**:
    - **200 OK**:
      ```json
      {
        "id": 1,
        "name": "Room 101"
      }
      ```
    - **404 Not Found** (if classroom does not exist):
      ```json
      {
        "error": "Classroom not found"
      }
      ```

- **PUT /api/v1/classrooms/:id**
  - **Description**: Update a specific classroom.
  - **Request Body**:
    ```json
    {
      "classroom": {
        "name": "Room 103"
      }
    }
    ```
  - **Response**:
    - **200 OK**:
      ```json
      {
        "id": 1,
        "name": "Room 103"
      }
      ```

- **DELETE /api/v1/classrooms/:id**
  - **Description**: Delete a specific classroom.
  - **Response**:
    - **204 No Content** (if successfully deleted).

#### 4. Subjects

- **GET /api/v1/subjects**
  - **Description**: Retrieve a list of all subjects.
  - **Response**:
    ```json
    [
      {
        "id": 1,
        "name": "Mathematics"
      }
    ]
    ```

- **POST /api/v1/subjects**
  - **Description**: Create a new subject.
  - **Request Body**:
    ```json
    {
      "subject": {
        "name": "Physics"
      }
    }
    ```
  - **Response**:
    - **201 Created**:
      ```json
      {
        "id": 2,
        "name": "Physics"
      }
      ```
    - **422 Unprocessable Entity** (if validation fails):
      ```json
      {
        "error": {
          "name": ["can't be blank"]
        }
      }
      ```

- **GET /api/v1/subjects/:id**
  - **Description**: Retrieve a specific subject by ID.
  - **Response**:
    - **200 OK**:
      ```json
      {
        "id": 1,
        "name": "Mathematics"
      }
      ```
    - **404 Not Found** (if subject does not exist):
      ```json
      {
        "error": "Subject not found"
      }
      ```

- **PUT /api/v1/subjects/:id**
  - **Description**: Update a specific subject.
  - **Request Body**:
    ```json
    {
      "subject": {
        "name": "Advanced Mathematics"
      }
    }
    ```
  - **Response**:
    - **200 OK**:
      ```json
      {
        "id": 1,
        "name": "Advanced Mathematics"
      }
      ```

- **DELETE /api/v1/subjects/:id**
  - **Description**: Delete a specific subject.
  - **Response**:
    - **204 No Content** (if successfully deleted).

#### 5. Teachers

- **GET /api/v1/teachers**
  - **Description**: Retrieve a list of all teachers.
  - **Response**:
    ```json
    [
      {
        "id": 1,
        "name": "Dr. Smith",
        "email": "dr.smith@example.com"
      }
    ]
    ```

- **POST /api/v1/teachers**
  - **Description**: Create a new teacher.
  - **Request Body**:
    ```json
    {
      "teacher": {
        "name": "Dr. Jane Doe",
        "email": "dr.jane.doe@example.com"
      }
    }
    ```
  - **Response**:
    - **201 Created**:
      ```json
      {
        "id": 2,
        "name": "Dr. Jane Doe",
        "email": "dr.jane.doe@example.com"
      }
      ```
    - **422 Unprocessable Entity** (if validation fails):
      ```json
      {
        "error": {
          "email": ["has already been taken"]
        }
      }
      ```

- **GET /api/v1/teachers/:id**
  - **Description**: Retrieve a specific teacher by ID.
  - **Response**:
    - **200 OK**:
      ```json
      {
        "id": 1,
        "name": "Dr. Smith",
        "email": "dr.smith@example.com"
      }
      ```
    - **404 Not Found** (if teacher does not exist):
      ```json
      {
        "error": "Teacher not found"
      }
      ```

- **PUT /api/v1/teachers/:id**
  - **Description**: Update a specific teacher.
  - **Request Body**:
    ```json
    {
      "teacher": {
        "name": "Dr. John Smith",
        "email": "dr.john.smith@example.com"
      }
    }
    ```
  - **Response**:
    - **200 OK**:
      ```json
      {
        "id": 1,
        "name": "Dr. John Smith",
        "email": "dr.john.smith@example.com"
      }
      ```

- **DELETE /api/v1/teachers/:id**
  - **Description**: Delete a specific teacher.
  - **Response**:
    - **204 No Content** (if successfully deleted).

## Running Tests

To run the test suite, use the following command:
