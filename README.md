# Staff Biometric Attendance System

A modern staff attendance system with face recognition capabilities using Spring Boot and Supabase.

## Features

- Face Recognition for staff sign-in/sign-out
- QR Code scanning as alternative authentication
- Photo upload and storage in Supabase
- Real-time face matching using advanced algorithms
- Staff management (add, view, edit)
- Attendance tracking
- Clean and modern UI
- Responsive design for mobile and desktop

## Tech Stack

**Backend:**
- Spring Boot 3.1.4
- Spring Data JPA
- PostgreSQL (Supabase)
- Java 17

**Frontend:**
- Pure HTML, CSS, JavaScript
- WebRTC for camera access
- Canvas API for image processing

## Database Setup

The database is already configured to use Supabase. You need to set the database password in the `.env` file:

```env
SUPABASE_DB_PASSWORD=your_database_password
```

The database schema includes:
- `staff` table: Stores staff information with photos (base64)
- `attendance` table: Tracks sign-in and sign-out times

## Prerequisites

1. Java 17 or higher
2. Maven (included via mvnw wrapper)
3. Supabase account (already configured)
4. Modern web browser with camera support

## Installation & Running

1. Set the database password in `.env`:
   ```bash
   echo "SUPABASE_DB_PASSWORD=your_password" >> .env
   ```

2. Build the project:
   ```bash
   ./mvnw clean package
   ```

3. Run the application:
   ```bash
   ./mvnw spring-boot:run
   ```

4. Open your browser and navigate to:
   ```
   http://localhost:8080
   ```

## How to Use

### Adding Staff

1. Click "Add New Staff"
2. Enter staff details (Name, Employee ID, Designation)
3. Upload a clear photo of the staff member's face
4. Click "Add Staff"
5. A QR code will be generated for the staff member

### Sign In / Sign Out

**Using Face Recognition:**
1. Click "Sign In" or "Sign Out"
2. Allow camera access when prompted
3. Position your face in the circular overlay
4. Click "Capture & Match"
5. The system will match your face and record attendance

**Using QR Code:**
1. Click "Sign In" or "Sign Out"
2. Click "Scan QR Code"
3. Enter the Employee ID from the QR code
4. Attendance will be recorded

### View Staff

Click "View All Staff" to see all registered staff members with their photos and details.

## API Endpoints

### Staff Management
- `POST /api/staff` - Add new staff
- `GET /api/staff` - Get all staff
- `GET /api/staff/{employeeId}` - Get staff by employee ID

### Attendance
- `POST /api/attendance/signin` - Sign in staff
- `POST /api/attendance/signout` - Sign out staff
- `GET /api/attendance?date=YYYY-MM-DD` - Get attendance by date

## Face Recognition Algorithm

The system uses a pixel-based comparison algorithm:
1. Captures image from camera
2. Converts to grayscale luminance values
3. Compares with all stored staff photos
4. Calculates RMSE (Root Mean Square Error)
5. Matches if score is below threshold (35)

## Security Features

- Row Level Security (RLS) enabled on all tables
- Photo data stored as base64 in database
- Input validation on all endpoints
- CORS configured for security

## Troubleshooting

**Camera not working:**
- Ensure you're using HTTPS or localhost
- Grant camera permissions in browser
- Try a different browser

**Face not matching:**
- Ensure good lighting
- Face the camera directly
- Use a clear, front-facing photo when registering
- Adjust the threshold in code if needed (line 356 in index.html)

**Database connection errors:**
- Verify SUPABASE_DB_PASSWORD is set correctly
- Check network connectivity to Supabase

## Future Enhancements

- Live video face detection (continuous scanning)
- ML-based face recognition (Face-API.js or TensorFlow.js)
- Attendance reports and analytics
- Email notifications
- Mobile app version
- Fingerprint integration

## License

MIT License
