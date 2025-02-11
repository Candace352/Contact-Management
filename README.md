# Contact Management Application

This is a semester-long project done in Flutter, where several tasks will be completed weekly. The goal is to design a fully functioning Flutter application by the end of the semester.

## Task 1

**Lab Tasks:**

### Task 1: Project Setup

1. Created a new Flutter project named 'contact_management_app'
2. Established a basic folder structure in the lib folder:
   - `screens/` or `pages/`
   - `services/`
   - `models/` (optional)

### Task 2: Bottom Navigation Implementation

1. Created four screens in the `screens/` folder:
   - `contacts_list.dart`
   - `add_contact.dart`
   - `edit_contact.dart`
   - `about.dart`

2. Implemented a bottom navigation bar in `main.dart` with four sections:
   - Contacts List (using a contacts icon)
   - Add Contact (using an add icon)
   - About (using an info icon)
   - Helpful resource – [link here]
   
3. Ensured proper navigation between screens using named routes or `MaterialPageRoute`.
   - Helpful resources for named routes: [link here]
   - Helpful resources for `MaterialPageRoute` routes: [link here]

4. Added appropriate titles in the AppBar for each screen.

## Testing

The application has been tested on a Samsung A12 device. The core features, such as creating, editing, and deleting contacts, have been successfully implemented. Here's a summary of the testing:

- **Creating a Contact:** The feature works successfully, and contacts are added as expected. However, the saving process seems a bit slow, but this is still under development.
  
- **Saving Contacts:** Despite the slight delay in saving, contacts are stored correctly.

- **Editing Contacts:** The edit functionality works as intended. Users can modify details of existing contacts without issues.

- **Deleting Contacts:** The delete operation works flawlessly, allowing contacts to be removed as expected.

Overall, the app's basic functionalities are working well, but there are areas (such as saving speed) that will be optimized in future developments.
