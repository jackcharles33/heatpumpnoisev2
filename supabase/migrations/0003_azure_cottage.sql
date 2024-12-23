/*
  # Fix noise assessments table structure
  
  1. Changes
    - Drop existing table and constraints
    - Recreate table without user_id requirement
    - Set up public access policies
*/

-- Drop existing table and its dependencies
DROP TABLE IF EXISTS noise_assessments CASCADE;

-- Recreate table without user_id
CREATE TABLE noise_assessments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at timestamptz DEFAULT now(),
  model text NOT NULL,
  sound_power_level numeric NOT NULL,
  directivity text NOT NULL,
  horizontal_distance numeric NOT NULL,
  stories integer NOT NULL,
  barrier_reduction numeric NOT NULL,
  final_level numeric NOT NULL,
  passes boolean NOT NULL
);

-- Enable RLS and set up public access
ALTER TABLE noise_assessments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public access to noise assessments"
  ON noise_assessments
  FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);