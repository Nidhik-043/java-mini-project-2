/*
  # Staff Biometric System Database Schema

  1. New Tables
    - `staff`
      - `id` (uuid, primary key)
      - `name` (text) - Full name of the staff member
      - `employee_id` (text, unique) - Unique employee identifier
      - `designation` (text) - Job title/position
      - `photo_base64` (text) - Base64 encoded photo for face recognition
      - `created_at` (timestamptz) - Record creation timestamp
      - `updated_at` (timestamptz) - Last update timestamp
    
    - `attendance`
      - `id` (uuid, primary key)
      - `employee_id` (text) - References staff.employee_id
      - `date` (date) - Attendance date
      - `sign_in_time` (timestamptz) - Time of sign in
      - `sign_out_time` (timestamptz) - Time of sign out
      - `created_at` (timestamptz) - Record creation timestamp
      - `updated_at` (timestamptz) - Last update timestamp

  2. Security
    - Enable RLS on both tables
    - Add policies for public access (for demo purposes)
    - Add indexes for performance

  3. Important Notes
    - Employee ID must be unique
    - Composite unique constraint on attendance (employee_id, date)
    - Indexes on employee_id and date for fast lookups
*/

-- Create staff table
CREATE TABLE IF NOT EXISTS staff (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  employee_id text UNIQUE NOT NULL,
  designation text DEFAULT '',
  photo_base64 text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create attendance table
CREATE TABLE IF NOT EXISTS attendance (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  employee_id text NOT NULL,
  date date NOT NULL DEFAULT CURRENT_DATE,
  sign_in_time timestamptz,
  sign_out_time timestamptz,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(employee_id, date)
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_staff_employee_id ON staff(employee_id);
CREATE INDEX IF NOT EXISTS idx_attendance_employee_id ON attendance(employee_id);
CREATE INDEX IF NOT EXISTS idx_attendance_date ON attendance(date);
CREATE INDEX IF NOT EXISTS idx_attendance_employee_date ON attendance(employee_id, date);

-- Enable Row Level Security
ALTER TABLE staff ENABLE ROW LEVEL SECURITY;
ALTER TABLE attendance ENABLE ROW LEVEL SECURITY;

-- Create policies for public access (for demo purposes)
-- In production, you should restrict these based on authentication
DROP POLICY IF EXISTS "Allow public read access to staff" ON staff;
CREATE POLICY "Allow public read access to staff"
  ON staff FOR SELECT
  TO anon, authenticated
  USING (true);

DROP POLICY IF EXISTS "Allow public insert to staff" ON staff;
CREATE POLICY "Allow public insert to staff"
  ON staff FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public update to staff" ON staff;
CREATE POLICY "Allow public update to staff"
  ON staff FOR UPDATE
  TO anon, authenticated
  USING (true)
  WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public read attendance" ON attendance;
CREATE POLICY "Allow public read attendance"
  ON attendance FOR SELECT
  TO anon, authenticated
  USING (true);

DROP POLICY IF EXISTS "Allow public insert attendance" ON attendance;
CREATE POLICY "Allow public insert attendance"
  ON attendance FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public update attendance" ON attendance;
CREATE POLICY "Allow public update attendance"
  ON attendance FOR UPDATE
  TO anon, authenticated
  USING (true)
  WITH CHECK (true);

-- Insert sample staff member
INSERT INTO staff (name, employee_id, designation, photo_base64)
VALUES ('John Doe', 'EMP001', 'Sales', null)
ON CONFLICT (employee_id) DO NOTHING;

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for updated_at
DROP TRIGGER IF EXISTS update_staff_updated_at ON staff;
CREATE TRIGGER update_staff_updated_at
  BEFORE UPDATE ON staff
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_attendance_updated_at ON attendance;
CREATE TRIGGER update_attendance_updated_at
  BEFORE UPDATE ON attendance
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();
