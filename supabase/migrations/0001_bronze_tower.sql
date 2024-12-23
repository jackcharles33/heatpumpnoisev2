/*
  # Create noise assessments table

  1. New Tables
    - `noise_assessments`
      - `id` (uuid, primary key)
      - `created_at` (timestamp)
      - `model` (text)
      - `sound_power_level` (numeric)
      - `directivity` (text)
      - `horizontal_distance` (numeric)
      - `stories` (integer)
      - `barrier_reduction` (numeric)
      - `final_level` (numeric)
      - `passes` (boolean)

  2. Security
    - Enable RLS
    - Add policy for authenticated users to insert their own assessments
    - Add policy for authenticated users to read their own assessments
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
  passes boolean NOT NULL,
  user_id uuid NOT NULL REFERENCES auth.users(id)
);

ALTER TABLE noise_assessments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can insert their own assessments"
  ON noise_assessments
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can read their own assessments"
  ON noise_assessments
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);