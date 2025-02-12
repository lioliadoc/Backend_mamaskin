# MamaSkin
MamaSkin is a web application designed to help pregnant women find information about pregnancy-related skin conditions. Users can enter symptoms to search for conditions, view images and references, and determine whether they should consult a healthcare provider. MamaSkin also includes a community stories feature where users can share personal experiences.

<img src="app/static/images/mamaskin_demo/MamaSkinHomePage.jpg" alt="HomePage" width="250" height="400">, 
<img src="app/static/images/mamaskin_demo/ConditionsListPage.jpg" alt="HomePage" width="250" height="400">,
<img src="app/static/images/mamaskin_demo/ConditionImages.jpg" alt="HomePage" width="250" height="is 400">,
<img src="app/static/images/mamaskin_demo/StoriesLogin.jpg" alt="HomePage" width="250" height="400">,
<img src="app/static/images/mamaskin_demo/PostStory.png" alt="HomePage" width="500" height="250">,

## Description
MamaSkin is a Flask + React application created as a capstone project. It allows pregnant women to:

Search for potential skin conditions by entering symptoms (supports both single words and multiple words).
View condition details, including description, references, and whether a healthcare provider is recommended.
See example images for each condition (fetched from static image paths).
Share personal stories regarding pregnancy-related skin issues (like a mini blog).
Authenticate via Google OAuth to enable user-specific features (e.g., posting stories, liking stories, etc.).

### Key Features
Symptom-based Search: 
- Type in keywords (e.g., “rash on stomach”), and see matched conditions.
- Condition Details: Each condition has references, a description, and an indicator for professional consultation.
- Images: A button to view pictures related to the condition.
- User Stories: Authenticated users can post stories about their experiences, which are stored in the database.
- Google OAuth: Integration via Authlib to allow users to sign in with their Google account.
- Cross-Origin: Configured CORS so the React frontend (deployed separately) can talk to the Flask API.

#### Technologies and Dependencies
1. Backend

- Python 3.10+
- Flask (for the server & API routes)
- Flask SQLAlchemy (ORM)
- Authlib (for Google OAuth)
- Flask Migrate (database migrations)
- PostgreSQL (database)
- Frontend

2. React
- TypeScript and JavaScript
- Bootstrap / React-Bootstrap for styling
3. Other Tools

- dotenv for environment variables
- pytest for testing
- Heroku

#### Installation and Setup




