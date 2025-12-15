# Setup Guide - Staff Biometric Attendance System

## Quick Start

This guide will help you set up and run the Staff Biometric Attendance System.

## Step 1: Get Supabase Database Password

Your Supabase database is already provisioned. To get the database password:

1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Select your project: `ycifyhjwxmcstvotxhgm`
3. Go to **Settings** > **Database**
4. Copy the database password

## Step 2: Configure Environment Variables

Add your Supabase database password to the `.env` file:

```bash
# Edit the .env file
nano .env

# Add this line (replace YOUR_PASSWORD with actual password):
SUPABASE_DB_PASSWORD=YOUR_PASSWORD
```

Or use this command:
```bash
echo "SUPABASE_DB_PASSWORD=your_actual_password" >> .env
```

## Step 3: Install Java (if not installed)

Check if Java is installed:
```bash
java -version
```

If Java is not installed:

**On Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install openjdk-17-jdk
```

**On macOS:**
```bash
brew install openjdk@17
```

**On Windows:**
Download and install from [Oracle JDK](https://www.oracle.com/java/technologies/downloads/) or [OpenJDK](https://adoptium.net/)

## Step 4: Build the Project

Make the Maven wrapper executable:
```bash
chmod +x mvnw
```

Build the project:
```bash
./mvnw clean package
```

This will:
- Download all dependencies
- Compile the code
- Create an executable JAR file

## Step 5: Run the Application

Start the Spring Boot application:
```bash
./mvnw spring-boot:run
```

Or run the JAR directly:
```bash
java -jar target/attendance-0.0.1-SNAPSHOT.jar
```

You should see output like:
```
Started DemoApplication in 3.456 seconds
```

## Step 6: Access the Application

Open your web browser and go to:
```
http://localhost:8080
```

## First Use: Add Your First Staff Member

1. Click **"Add New Staff"**
2. Fill in the details:
   - Full Name: John Doe
   - Employee ID: EMP001
   - Designation: Manager
3. Click **"Upload Photo"** and select a clear front-facing photo
4. Click **"Add Staff"**
5. A QR code will be generated

## Test Face Recognition

1. Click **"Sign In"**
2. Allow camera access when prompted
3. Position your face in the camera view
4. Click **"Capture & Match"**
5. If the face matches, attendance will be recorded

## Important Notes

### Camera Requirements
- Use HTTPS or localhost (http://localhost:8080)
- Modern browser (Chrome, Firefox, Edge, Safari)
- Grant camera permissions when requested
- Good lighting for better face recognition

### Photo Requirements
- Clear, front-facing photo
- Good lighting
- Face clearly visible
- No sunglasses or heavy makeup recommended
- Recommended size: 640x480 or higher

### Face Matching Tips
- Face the camera directly
- Ensure good lighting
- Keep face centered in the overlay
- Remove glasses if possible
- Maintain similar expression to registration photo

## Troubleshooting

### Issue: "Cannot connect to database"
**Solution:** Check that SUPABASE_DB_PASSWORD is set correctly in `.env`

### Issue: "Camera not working"
**Solutions:**
- Use localhost or HTTPS
- Grant camera permissions in browser settings
- Try a different browser
- Check if camera is being used by another app

### Issue: "Face not matching"
**Solutions:**
- Improve lighting conditions
- Face camera directly
- Use a better quality photo during registration
- Adjust threshold value (edit line 356 in index.html)

### Issue: "Port 8080 already in use"
**Solution:** Change port in `application.properties`:
```properties
server.port=8081
```

### Issue: Java not found
**Solution:** Install Java 17 or higher (see Step 3)

## Database Schema

The system automatically creates these tables in Supabase:

### staff table
```sql
- id (UUID, primary key)
- name (text)
- employee_id (text, unique)
- designation (text)
- photo_base64 (text) -- Stores face photo
- created_at (timestamp)
- updated_at (timestamp)
```

### attendance table
```sql
- id (UUID, primary key)
- employee_id (text)
- date (date)
- sign_in_time (timestamp)
- sign_out_time (timestamp)
- created_at (timestamp)
- updated_at (timestamp)
```

## Configuration Files

### application.properties
Database and server configuration

### .env
Environment variables (Supabase credentials)

## API Testing

You can test the API using curl or Postman:

### Add Staff
```bash
curl -X POST http://localhost:8080/api/staff \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "employeeId": "EMP001",
    "designation": "Manager",
    "photoBase64": "data:image/jpeg;base64,..."
  }'
```

### Sign In
```bash
curl -X POST http://localhost:8080/api/attendance/signin \
  -H "Content-Type: application/json" \
  -d '{"employeeId": "EMP001"}'
```

### Get All Staff
```bash
curl http://localhost:8080/api/staff
```

## Production Deployment

For production deployment:

1. Set environment variables properly
2. Use HTTPS for camera access
3. Configure proper CORS settings
4. Enable RLS policies in Supabase
5. Use production database credentials
6. Consider using a reverse proxy (Nginx)
7. Set up proper logging and monitoring

## Support

For issues or questions:
1. Check the troubleshooting section
2. Review application logs
3. Check Supabase dashboard for database issues
4. Verify camera permissions in browser settings

## Next Steps

- Add more staff members
- Test face recognition with different lighting
- Try QR code scanning
- View attendance records
- Export attendance data (coming soon)
