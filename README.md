# Contact Management App

This is a semester-long project developed in Flutter as part of the CS 443 – Mobile Application Development course. The project will involve weekly tasks, leading to a fully functioning Flutter application by the end of the semester.

## Task 1: Project Setup

### Lab Tasks:
1. Created a new Flutter project named `contact_management_app`.
2. Established a basic folder structure in the `lib` folder:
   - `screens/` or `pages/`
   - `services/`
   - `models/` (optional)

## Task 2: Bottom Navigation Implementation

### Implementation Details:
- Created four screens in the `screens/` folder:
  1. `contacts_list.dart`
  2. `add_contact.dart`
  3. `edit_contact.dart`
  4. `about.dart`
- Implemented a bottom navigation bar in `main.dart` with four sections:
  - **Contacts List** (using a contacts icon)
  - **Add Contact** (using an add icon)
  - **Edit Contact** (optional, for modifying existing contacts)
  - **About** (using an info icon)
- Ensured proper navigation between screens using either named routes or `MaterialPageRoute`.

## Task 3: API Integration

Implemented API service methods to handle various contact management actions.

### API Endpoints:
1. **Get Single Contact**
   - **Endpoint:** `https://apps.ashesi.edu.gh/contactmgt/actions/get_a_contact_mob?contid=6`
   - **Method:** GET
   - **Response:** JSON list of contacts (pid, pname, pphone)

2. **Get All Contacts**
   - **Endpoint:** `https://apps.ashesi.edu.gh/contactmgt/actions/get_all_contact_mob`
   - **Method:** GET
   - **Response:** JSON list of contacts (pid, pname, pphone)

3. **Add New Contact**
   - **Endpoint:** `https://apps.ashesi.edu.gh/contactmgt/actions/add_contact_mob`
   - **Method:** POST
   - **Required Data:** `{ufullname:data, uphonename:data}`
   - **Response:** success/failed (string)

4. **Edit Contact**
   - **Endpoint:** `https://apps.ashesi.edu.gh/contactmgt/actions/update_contact`
   - **Method:** POST
   - **Required Data:** `{cname: formdata, cnum: formdata, cid: formdata}`
   - **Response:** success/failed (string)

5. **Delete Contact**
   - **Endpoint:** `https://apps.ashesi.edu.gh/contactmgt/actions/delete_contact`
   - **Method:** POST
   - **Required Data:** `{cid:data}`
   - **Response:** true/false (Boolean) or StatusCode of 200 (OK)

## Testing
The application has been tested on a Samsung A12 device. The core features, such as creating, editing, and deleting contacts, have been successfully implemented.

### Summary of Testing:
- **Creating a Contact:** Contacts are added as expected, though saving speed requires optimization.
- **Saving Contacts:** Contacts are stored correctly despite a slight delay.
- **Editing Contacts:** Users can modify details without issues.
- **Deleting Contacts:** Contacts can be removed successfully.

Overall, the app’s basic functionalities work well, with future improvements focusing on performance optimization.
P.S: This was my first Flutter application in 2 semesters, keep an open mind😬
