/*
  # Create noise assessments table with public access

  1. New Tables
    - `noise_assessments`
      - `id` (uuid, primary key)
      - `created_at` (timestamptz)
      - `model` (text)
      - `sound_power_level` (numeric)
      - `directivity` (text)
      - `horizontal_distance` (numeric)
      - `stories` (integer)
      - `barrier_reduction` (numeric)
      - `final_level` (numeric)
      - `passes` (boolean)
  2. Security
    - Enable RLS on `noise_assessments` table
    - Add policy for public access
*/

CREATE TABLE IF NOT EXISTS noise_assessments (
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

ALTER TABLE noise_assessments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public access to noise assessments"
  ON noise_assessments
  FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);